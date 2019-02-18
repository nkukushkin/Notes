import UIKit

class NoteEditorCoordinator: Coordinator {

    private(set) var note: Note {
        didSet {
            noteEditorViewController.note = note
            didChangeNoteHandler?(note)
        }
    }

    var didChangeNoteHandler: ((Note) -> Void)?

    // MARK: NoteEditorViewController

    private weak var noteEditorViewController: NoteEditorViewController!

    private func showNoteEditorViewController() {
        let noteEditorViewController = NoteEditorViewController(note: note)

        noteEditorViewController.emojiIconTappedHandler = { [weak self] in
            self?.showEmojiPickerViewController()
        }

        self.noteEditorViewController = noteEditorViewController
        embedChild(noteEditorViewController, in: view)
    }

    // MARK: EmojiPickerViewController

    private func showEmojiPickerViewController() {
        #warning("TODO: Proper emoji")
        let emojiSelection = emojiCategories["people"]!
        let emojiPickerViewController = EmojiPickerViewController(emojiSelection: emojiSelection)

        emojiPickerViewController.title = note.icon
        emojiPickerViewController.didPickEmojiHandler = { [weak self] emoji in
            guard let self = self else { return }
            self.note.icon = emoji
            self.navigationController?.popViewController(animated: true)
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
