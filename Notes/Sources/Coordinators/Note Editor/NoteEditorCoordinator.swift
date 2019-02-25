import UIKit

class NoteEditorCoordinator: Coordinator {

    private(set) var note: Note {
        didSet {
            noteEditorViewController.setNote(note)
            didChangeNoteHandler?(note)
        }
    }

    var didChangeNoteHandler: ((Note) -> Void)?

    // MARK: - NoteEditorViewController

    private weak var noteEditorViewController: NoteEditorViewController!

    private func showNoteEditorViewController() {
        let noteEditorViewController = NoteEditorViewController(note: note)

        noteEditorViewController.didTapEmojiHandler = { [weak self] in
            self?.showEmojiPickerViewController()
        }
        noteEditorViewController.didChangeNoteHandler = { [weak self] note in
            self?.note = note
        }

        self.noteEditorViewController = noteEditorViewController
        embedChild(noteEditorViewController, in: view)
    }

    // MARK: - EmojiPickerViewController

    private func showEmojiPickerViewController() {
        let emojis = emojiCategories["people"]!
        let emojiPickerViewController = EmojiPickerViewController(emojis: emojis)

        emojiPickerViewController.navigationItem.title = note.emoji
        emojiPickerViewController.didPickEmojiHandler = { [weak self] emoji in
            guard let self = self else { return }
            self.note.emoji = emoji
            self.navigationController?.popViewController(animated: true)
        }

        navigationController?.pushViewController(emojiPickerViewController, animated: true)
    }

    // MARK: - View Lifecycle

    override func loadView() {
        super.loadView()
        showNoteEditorViewController()
    }

    // MARK: - Initialization

    init(note: Note) {
        self.note = note
        super.init()
    }
}
