import UIKit

class NoteListCoordinator: Coordinator {
    private lazy var rootNavigationController = UINavigationController()

    private let noteStorage: NoteStorage

    // MARK: Note List View Controller

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
            self?.showNoteEditorViewController(for: note)
        }

        noteListViewController.navigationItem.title = LocalizedStrings.noteListNavigationTitle
        noteListViewController.navigationItem.rightBarButtonItem = newNoteBarButtonItem

        self.noteListViewController = noteListViewController
        rootNavigationController.pushViewController(noteListViewController, animated: true)
    }

    // MARK: New Note Coordinator

    @objc
    private func showNewNoteCoordinator() {
        let newNoteCoordinator = NewNoteCoordinator()

        newNoteCoordinator.noteCreatedHandler = { [weak self, weak newNoteCoordinator] note in
            self?.noteStorage.save(note: note)
            newNoteCoordinator?.dismiss(animated: true)
        }
        newNoteCoordinator.cancelHandler = { [weak newNoteCoordinator] in
            newNoteCoordinator?.dismiss(animated: true)
        }

        present(newNoteCoordinator, animated: true)
    }

    // MARK: Note Editor View Controller

    private var openNote: Note?

    private lazy var deleteNoteBarButtonItem = UIBarButtonItem(
        barButtonSystemItem: .trash,
        target: self,
        action: #selector(deleteOpenNote)
    )

    private func showNoteEditorViewController(for note: Note) {
        let noteEditorViewController = NoteEditorViewController(note: note)
        noteEditorViewController.navigationItem.rightBarButtonItem = deleteNoteBarButtonItem
        rootNavigationController.pushViewController(noteEditorViewController, animated: true)
    }

    @objc
    private func deleteOpenNote() {
        #warning("TODO: Delete note")
        rootNavigationController.popViewController(animated: true)
    }

    // MARK: Observation

    private var noteStorageObservationToken: NoteStorage.ObservationToken?

    private func startObservingNoteStorage() {
        let observation: NoteStorage.Observation = { [weak self] _, newNotes in
            self?.noteListViewController.notes = newNotes
        }
        noteStorageObservationToken = noteStorage.addObservation(observation)
    }

    private func stopObservingNoteStorage() {
        guard let token = noteStorageObservationToken else { return }
        noteStorage.removeObservation(for: token)
        noteStorageObservationToken = nil
    }

    // MARK: Lifecycle

    override func loadView() {
        super.loadView()
        embedChild(rootNavigationController, in: view)
        showNoteListViewController()
        startObservingNoteStorage()
    }

    // MARK: Initialization

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
