import UIKit

class NotesCoordinator: Coordinator {
    private lazy var embeddedNavigationController: UINavigationController = {
        let navigationController = UINavigationController()
        navigationController.navigationBar.prefersLargeTitles = true
        return navigationController
    }()

    private let noteStorage: NoteStorage

    // MARK: - Notes Table

    private lazy var newNoteBarButtonItem = UIBarButtonItem(
        barButtonSystemItem: .compose,
        target: self,
        action: #selector(showNewNoteCoordinator)
    )

    // This coordinator will be at the navigation controller’s root,
    // and it will never go away, therefore we can make it implicitly unwrapped.
    private weak var notesTableCoordinator: NotesTableCoordinator!

    private func showNotesTableCoordinator() {
        let notes = noteStorage.notes.value
        let viewData = NotesTableCoordinator.ViewData(notes: notes)
        let notesTableCoordinator = NotesTableCoordinator(viewData: viewData)

        notesTableCoordinator.noteSelectedHanlder = { [weak self] note in
            self?.showNoteEditorCoordinator(for: note)
        }
        notesTableCoordinator.noteDeletedHandler = { [weak self] note in
            self?.noteStorage.delete(note: note)
        }
        notesTableCoordinator.addNewNoteHandler = { [weak self] in
            self?.showNewNoteCoordinator()
        }

        notesTableCoordinator.navigationItem.title = LocalizedStrings.notesTableNavigationTitle
        notesTableCoordinator.navigationItem.rightBarButtonItem = newNoteBarButtonItem

        self.notesTableCoordinator = notesTableCoordinator
        embeddedNavigationController.pushViewController(notesTableCoordinator, animated: true)
    }

    // MARK: - New Note

    @objc
    private func showNewNoteCoordinator() {
        let newNoteCoordinator = NewNoteCoordinator()

        newNoteCoordinator.didCreateNoteHandler = { [weak self, unowned newNoteCoordinator] note in
            self?.noteStorage.save(note: note)
            newNoteCoordinator.dismiss(animated: true)
        }
        newNoteCoordinator.cancelHandler = { [unowned newNoteCoordinator] in
            newNoteCoordinator.dismiss(animated: true)
        }

        present(newNoteCoordinator, animated: true)
    }

    // MARK: - Note Editor

    private lazy var deleteEditedNoteBarButtonItem = UIBarButtonItem(
        barButtonSystemItem: .trash,
        target: self,
        action: #selector(deleteEditedNote)
    )

    @objc
    private func deleteEditedNote() {
        guard let editedNote = editedNote else { return }
        noteStorage.delete(note: editedNote)
    }

    private var editedNote: Note? {
        return noteEditorCoordinator?.note
    }

    private weak var noteEditorCoordinator: NoteEditorCoordinator?

    private func showNoteEditorCoordinator(for note: Note) {
        let noteEditorCoordinator = NoteEditorCoordinator(
            note: note,
            navigationController: embeddedNavigationController
        )

        noteEditorCoordinator.navigationItem.rightBarButtonItem = deleteEditedNoteBarButtonItem
        noteEditorCoordinator.navigationItem.largeTitleDisplayMode = .never
        noteEditorCoordinator.didChangeNoteHandler = { [weak self] note in
            // Called on every character change.
            self?.noteStorage.save(note: note)
        }

        self.noteEditorCoordinator = noteEditorCoordinator
        embeddedNavigationController.pushViewController(noteEditorCoordinator, animated: true)
    }

    // MARK: - Observation

    private var notesObservationToken: ScopedObservationToken?

    private func beginObservingNotes() {
        notesObservationToken = noteStorage.notes.observe { [weak self] oldNotes, newNotes in
            self?.handleNotesChange(oldNotes: oldNotes, newNotes: newNotes)
        }
    }

    private func handleNotesChange(oldNotes: [Note], newNotes: [Note]) {
        let viewData = NotesTableCoordinator.ViewData(notes: newNotes)
        notesTableCoordinator.viewData = viewData

        // Pop note editor if the note it’s editing gets deleted.
        if let editedNote = editedNote, !newNotes.contains(editedNote) {
            embeddedNavigationController.popToViewController(notesTableCoordinator, animated: true)
        }
    }

    // MARK: - View Lifecycle

    override func loadView() {
        super.loadView()
        embedChild(embeddedNavigationController, in: view)
        showNotesTableCoordinator()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        beginObservingNotes()
    }

    // MARK: - Initialization

    init(noteStorage: NoteStorage) {
        self.noteStorage = noteStorage
        super.init()
    }
}

// MARK: - Localized Strings

private enum LocalizedStrings {
    static var notesTableNavigationTitle: String {
        return NSLocalizedString(
            "Notes",
            comment: "Navigation bar title for the screen that shows table of notes."
        )
    }
}
