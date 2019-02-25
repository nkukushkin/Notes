import UIKit

class NotesCoordinator: Coordinator {
    private lazy var rootNavigationController: UINavigationController = {
        let navigationController = UINavigationController()
        navigationController.navigationBar.prefersLargeTitles = true
        return navigationController
    }()

    private let noteStorage: NoteStorage

    // MARK: - Note List View Controller

    private lazy var newNoteBarButtonItem = UIBarButtonItem(
        barButtonSystemItem: .add,
        target: self,
        action: #selector(showNewNoteCoordinator)
    )

    private weak var noteListViewController: NoteListViewController!

    private func showNoteListViewController() {
        let notes = noteStorage.notes
        let noteListViewController = NoteListViewController(notes: notes)

        noteListViewController.noteSelectedHanlder = { [weak self] note in
            self?.showNoteEditorCoordinator(for: note)
        }

        noteListViewController.navigationItem.title = LocalizedStrings.noteListNavigationTitle
        noteListViewController.navigationItem.rightBarButtonItem = newNoteBarButtonItem

        self.noteListViewController = noteListViewController
        rootNavigationController.pushViewController(noteListViewController, animated: true)
    }

    // MARK: - New Note Coordinator

    @objc
    private func showNewNoteCoordinator() {
        let newNoteCoordinator = NewNoteCoordinator()

        newNoteCoordinator.didCreateNoteHandler = { [unowned noteStorage, unowned newNoteCoordinator] note in
            noteStorage.save(note: note)
            newNoteCoordinator.dismiss(animated: true)
        }
        newNoteCoordinator.cancelHandler = { [unowned newNoteCoordinator] in
            newNoteCoordinator.dismiss(animated: true)
        }

        present(newNoteCoordinator, animated: true)
    }

    // MARK: - Note Editor Coordinator

    private var openNote: Note?

    private lazy var deleteNoteBarButtonItem = UIBarButtonItem(
        barButtonSystemItem: .trash,
        target: self,
        action: #selector(deleteOpenNote)
    )

    private func showNoteEditorCoordinator(for note: Note) {
        openNote = note
        let noteEditorCoordinator = NoteEditorCoordinator(note: note)

        noteEditorCoordinator.navigationItem.rightBarButtonItem = deleteNoteBarButtonItem
        noteEditorCoordinator.navigationItem.largeTitleDisplayMode = .never
        noteEditorCoordinator.didChangeNoteHandler = { [unowned noteStorage] note in
            // This is called on every character change in the editor.
            noteStorage.save(note: note)
        }

        rootNavigationController.pushViewController(noteEditorCoordinator, animated: true)
    }

    @objc
    private func deleteOpenNote() {
        guard let openNote = openNote else { return }
        noteStorage.delete(note: openNote)
    }

    // MARK: - Observation

    private var noteStorageObservationToken: NoteStorage.ObservationToken?

    private func startObservingNoteStorage() {
        let observation: NoteStorage.Observation = { [weak self] _, newNotes in
            guard let self = self else { return }
            self.noteListViewController.notes = newNotes

            // Pop to list if note was deleted.
            if let openNote = self.openNote, !self.noteStorage.notes.contains(openNote) {
                self.openNote = nil
                self.rootNavigationController.popToViewController(self.noteListViewController, animated: true)
            }
        }
        noteStorageObservationToken = noteStorage.addObservation(observation)
    }

    private func stopObservingNoteStorage() {
        guard let token = noteStorageObservationToken else { return }
        noteStorage.removeObservation(for: token)
        noteStorageObservationToken = nil
    }

    // MARK: - View Lifecycle

    override func loadView() {
        super.loadView()
        embedChild(rootNavigationController, in: view)
        showNoteListViewController()
        startObservingNoteStorage()
    }

    // MARK: - Initialization

    init(noteStorage: NoteStorage) {
        self.noteStorage = noteStorage
        super.init()
    }

    deinit {
        stopObservingNoteStorage()
    }
}

// MARK: - Localized Strings

private enum LocalizedStrings {
    static var noteListNavigationTitle: String {
        return NSLocalizedString(
            "Notes",
            comment: "Navigation bar title for the screen that shows a list of notes."
        )
    }
}
