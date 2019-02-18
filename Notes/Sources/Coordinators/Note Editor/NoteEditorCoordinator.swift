import UIKit

class NoteEditorCoordinator: Coordinator {

    private(set) var note: Note

    // MARK: NoteEditorViewController

    private func showNoteEditorViewController() {
        let noteEditorViewController = NoteEditorViewController(note: note)

        noteEditorViewController.emojiIconTappedHandler = { [weak self] in
            self?.showEmojiPickerViewController()
        }

        embedChild(noteEditorViewController, in: view)
    }

    // MARK: EmojiPickerViewController

    private func showEmojiPickerViewController() {
        let emojiPickerViewController = EmojiPickerViewController(emojiSelection: ["🐽","🐷"])

        emojiPickerViewController.emojiPickedHandler = { [weak emojiPickerViewController] emoji in
            print("picked emoji \(emoji)")
            emojiPickerViewController?.dismiss(animated: true)
        }

        navigationController?.pushViewController(emojiPickerViewController, animated: true)
    }

    // MARK: Lifecycle

    override func loadView() {
        super.loadView()
        showNoteEditorViewController()
    }

    // MARK: Initialization

    init(note: Note) {
        self.note = note
        super.init()
    }
}
