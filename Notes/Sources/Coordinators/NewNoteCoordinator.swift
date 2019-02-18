import UIKit

class NewNoteCoordinator: Coordinator {
    private lazy var rootNavigationController = UINavigationController()

    var noteCreatedHandler: ((Note) -> Void)?
    var cancelHandler: (() -> Void)?

    // MARK: Actions

    @objc
    private func done() {
        let note = noteEditorCoordinator.note
        noteCreatedHandler?(note)
    }

    @objc
    private func cancel() {
        cancelHandler?()
    }

    // MARK: Note Editor Coordinator

    private weak var noteEditorCoordinator: NoteEditorCoordinator!

    private func showNoteEditorViewController() {
        let newNote = Note(icon: "", title: "", body: "")
        let noteEditorCoordinator = NoteEditorCoordinator(note: newNote)

        let navigationItem = noteEditorCoordinator.navigationItem
        navigationItem.title = title
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .cancel,
            target: self, action: #selector(cancel)
        )
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .done,
            target: self, action: #selector(done)
        )

        self.noteEditorCoordinator = noteEditorCoordinator
        rootNavigationController.pushViewController(noteEditorCoordinator, animated: false)
    }

    // MARK: Lifecycle

    override func loadView() {
        super.loadView()
        embedChild(rootNavigationController, in: view)
        showNoteEditorViewController()
    }
}

// MARK: - Localized Strings

private enum LocalizedStrings {
    static var title: String {
        return NSLocalizedString(
            "New Note",
            comment: "Navigation bar title for the screen where user edits a new note."
        )
    }
}
