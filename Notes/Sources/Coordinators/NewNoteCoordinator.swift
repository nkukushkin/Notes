import UIKit

/*
 NewNoteCoordinator wraps NoteEditorCoordinator and extends it with
 a custom navigation title and bar buttons. It also creates the new
 note that will be edited by the child coordinator.

 This coordinator assumes that it will be presented modally, so it
 embeds it’s own embedded navigation controller.
 */
class NewNoteCoordinator: Coordinator {
    private lazy var embeddedNavigationController = UINavigationController()

    var didCreateNoteHandler: ((Note) -> Void)?
    var cancelHandler: (() -> Void)?

    // MARK: - Actions

    @objc
    private func done() {
        let note = noteEditorCoordinator.note
        didCreateNoteHandler?(note)
    }

    @objc
    private func cancel() {
        cancelHandler?()
    }

    // MARK: - Note Editor

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

    // This coordinator will be at the navigation controller’s root,
    // and it will never go away, therefore we can make it implicitly unwrapped.
    private weak var noteEditorCoordinator: NoteEditorCoordinator!

    private func showNoteEditorCoordinator() {
        let newNote = Note(icon: "📝", title: "", body: "")
        let noteEditorCoordinator = NoteEditorCoordinator(
            note: newNote,
            navigationController: embeddedNavigationController
        )

        let noteEditorNavigationItem = noteEditorCoordinator.navigationItem
        noteEditorNavigationItem.title = LocalizedStrings.newNoteEditorTitle
        noteEditorNavigationItem.leftBarButtonItem = cancelBarButtonItem
        noteEditorNavigationItem.rightBarButtonItem = doneBarButtonItem

        self.noteEditorCoordinator = noteEditorCoordinator
        embeddedNavigationController.pushViewController(noteEditorCoordinator, animated: false)
    }

    // MARK: - View Lifecycle

    override func loadView() {
        super.loadView()
        embedChild(embeddedNavigationController, in: view)
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
