import UIKit

class NewNoteCoordinator: Coordinator {

    private lazy var navController = UINavigationController()

    private let noteStorage: NoteStorage

    // MARK: Actions

    @objc
    private func done() {
        #warning("TODO: Implementation")
        dismiss(animated: true)
    }

    @objc
    private func cancel() {
        dismiss(animated: true)
    }

    // MARK: Note Editor View Controller

    private func showNoteEditorViewController() {
        let emptyNote = Note(icon: "", title: "", body: "")
        let noteEditorViewController = NoteEditorViewController(note: emptyNote)
        noteEditorViewController.navigationItem.title = LocalizedStrings.newNoteEditorNavigationTitle
        noteEditorViewController.navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .done,
            target: self, action: #selector(done)
        )
        noteEditorViewController.navigationItem.leftBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .cancel,
            target: self, action: #selector(cancel)
        )

        navController.pushViewController(noteEditorViewController, animated: false)
    }

    // MARK: Lifecycle

    override func loadView() {
        super.loadView()
        embedChild(navController, in: view)
        showNoteEditorViewController()
    }

    // MARK: Initialization

    init(noteStorage: NoteStorage) {
        self.noteStorage = noteStorage
        super.init()
    }
}

// MARK: - Localized Strings

private enum LocalizedStrings {
    static var newNoteEditorNavigationTitle: String {
        return NSLocalizedString(
            "New Note",
            comment: "Navigation bar title for the screen where user edits a new note."
        )
    }
}
