import UIKit

class NewNoteCoordinator: Coordinator {
    private lazy var rootNavigationController = UINavigationController()

    var didCreateNoteHandler: ((Note) -> Void)?
    var cancelHandler: (() -> Void)?

    // MARK: Actions

    @objc
    private func done() {
        let note = noteEditorCoordinator.note
        didCreateNoteHandler?(note)
    }

    @objc
    private func cancel() {
        cancelHandler?()
    }

    // MARK: Note Editor Coordinator

    private lazy var doneBarButtonItem = UIBarButtonItem(
        barButtonSystemItem: .done,
        target: self,
        action: #selector(done)
    )

    private lazy var cancelBarButtonItem = UIBarButtonItem(
        barButtonSystemItem: .cancel,
        target: self,
        action: #selector(cancel)
    )

    private weak var noteEditorCoordinator: NoteEditorCoordinator!

    private func showNoteEditorCoordinator() {
        let newNote = Note(icon: "", title: "", body: "")
        let noteEditorCoordinator = NoteEditorCoordinator(note: newNote)

        let noteEditorNavigationItem = noteEditorCoordinator.navigationItem
        noteEditorNavigationItem.title = LocalizedStrings.newNoteEditorTitle
        noteEditorNavigationItem.leftBarButtonItem = cancelBarButtonItem
        noteEditorNavigationItem.rightBarButtonItem = doneBarButtonItem

        self.noteEditorCoordinator = noteEditorCoordinator
        rootNavigationController.pushViewController(noteEditorCoordinator, animated: false)
    }

    // MARK: Lifecycle

    override func loadView() {
        super.loadView()
        embedChild(rootNavigationController, in: view)
        showNoteEditorCoordinator()
    }
}

// MARK: - Localized Strings

private enum LocalizedStrings {
    static var newNoteEditorTitle: String {
        return NSLocalizedString(
            "New Note",
            comment: "Navigation bar title for the screen where user edits a new note."
        )
    }
}
