import UIKit

class NoteListCoordinator: Coordinator {

    private lazy var rootNavigationController = UINavigationController()

    private let noteStorage: NoteStorage

    override func loadView() {
        super.loadView()
        embedChild(rootNavigationController, in: view)
        showNoteListViewController()
    }

    private func showNoteListViewController() {
        let notes = noteStorage.loadAllNotes()
        let sortedNotes = Array(notes).sorted(by: {
            $0.dateOfLastModification < $1.dateOfLastModification
        })
        let noteListViewController = NoteListViewController(notes: sortedNotes)
        noteListViewController.navigationItem.title = LocalizedStrings.noteListNavigationTitle

        rootNavigationController.pushViewController(noteListViewController, animated: true)
    }

    // MARK: - Initialization

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
