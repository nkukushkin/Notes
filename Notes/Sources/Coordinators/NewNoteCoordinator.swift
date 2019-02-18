import UIKit

class NewNoteCoordinator: Coordinator {
    private lazy var rootNavigationController = UINavigationController()

    var noteCreatedHandler: ((Note) -> Void)?
    var cancelHandler: (() -> Void)?

    // MARK: Actions

    @objc
    private func done() {
        let note = noteEditorViewController.note
        noteCreatedHandler?(note)
    }

    @objc
    private func cancel() {
        cancelHandler?()
    }

    // MARK: Note Editor View Controller

    private weak var noteEditorViewController: NoteEditorViewController!

    private func showNoteEditorViewController() {
        let newNote = Note(icon: "", title: "", body: "")
        let noteEditorViewController = NoteEditorViewController(note: newNote)

        noteEditorViewController.emojiIconTappedHandler = { [weak self] in

        }

        let navigationItem = noteEditorViewController.navigationItem
        navigationItem.title = title
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .cancel,
            target: self, action: #selector(cancel)
        )
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .done,
            target: self, action: #selector(done)
        )

        self.noteEditorViewController = noteEditorViewController
        rootNavigationController.pushViewController(noteEditorViewController, animated: false)
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
