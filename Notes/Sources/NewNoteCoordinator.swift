import UIKit

class NewNoteCoordinator: Coordinator {
    private lazy var _navigationController = UINavigationController()
    override var navigationController: UINavigationController! {
        return _navigationController
    }

    private let noteStorage: NoteStorage

    // MARK: Actions

    @objc
    private func saveNote() {
        let note = noteEditorViewController.note
        noteStorage.save(note: note)
        dismiss(animated: true)
    }

    @objc
    private func cancel() {
        dismiss(animated: true)
    }

    // MARK: Note Editor View Controller

    private weak var noteEditorViewController: NoteEditorViewController!

    private func showNoteEditorViewController() {
        let newNote = Note(icon: "", title: "", body: "")
        let noteEditorViewController = NoteEditorViewController(note: newNote)

        let navigationItem = noteEditorViewController.navigationItem
        navigationItem.title = title
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .cancel,
            target: self, action: #selector(cancel)
        )
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .done,
            target: self, action: #selector(saveNote)
        )

        self.noteEditorViewController = noteEditorViewController
        navigationController.pushViewController(noteEditorViewController, animated: false)
    }

    // MARK: Lifecycle

    override func loadView() {
        super.loadView()
        embedChild(navigationController, in: view)
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
    static var title: String {
        return NSLocalizedString(
            "New Note",
            comment: "Navigation bar title for the screen where user edits a new note."
        )
    }
}
