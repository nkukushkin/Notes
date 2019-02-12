import UIKit

class NoteListCoordinator: Coordinator {

    private lazy var navController = UINavigationController()

    private let noteStorage: NoteStorage

    // MARK: Note List View Controller

    private lazy var newNoteBarButtonItem = UIBarButtonItem(
        barButtonSystemItem: .add,
        target: self,
        action: #selector(showNewNoteCoordinator)
    )

    private func showNoteListViewController() {
        let notes = noteStorage.loadAllNotes()
        let sortedNotes = Array(notes).sorted(by: {
            $0.dateOfLastModification < $1.dateOfLastModification
        })
        let noteListViewController = NoteListViewController(notes: sortedNotes)
        noteListViewController.navigationItem.title = LocalizedStrings.noteListNavigationTitle
        noteListViewController.navigationItem.rightBarButtonItem = newNoteBarButtonItem

        navController.pushViewController(noteListViewController, animated: true)
    }

    // MARK: New Note Coordinator

    @objc
    private func showNewNoteCoordinator() {
        let newNoteCoordinator = NewNoteCoordinator(noteStorage: noteStorage)
        present(newNoteCoordinator, animated: true)
    }

    // MARK: Lifecycle

    override func loadView() {
        super.loadView()
        embedChild(navController, in: view)
        showNoteListViewController()
    }

    // MARK: Initialization

    init(noteStorage: NoteStorage) {
        self.noteStorage = noteStorage
        super.init()
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
