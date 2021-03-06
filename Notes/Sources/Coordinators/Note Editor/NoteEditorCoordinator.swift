import UIKit

/*
 NoteEditorCoordinator manages the flow between NoteEditorViewController
 and EmojiPickerViewController, where user can tap an emoji in the former and
 choose a new one in the latter.
 */
class NoteEditorCoordinator: Coordinator {
    private var inheritedNavigationController: UINavigationController

    private(set) var note: Note {
        didSet {
            noteEditorViewController.setNote(note)
            didChangeNoteHandler?(note)
        }
    }

    var didChangeNoteHandler: ((Note) -> Void)?

    // MARK: - NoteEditorViewController

    // This view controller is embedded in the coordinator,
    // so it will never go away, therefor we can make it implicitly unwrapped.
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
        let emojiPickerViewController = EmojiPickerViewController()

        emojiPickerViewController.navigationItem.title = note.emoji
        emojiPickerViewController.didPickEmojiHandler = { [weak self] emoji in
            guard let self = self else { return }
            self.note.emoji = emoji
            self.inheritedNavigationController.popViewController(animated: true)
        }

        inheritedNavigationController.pushViewController(emojiPickerViewController, animated: true)
    }

    // MARK: - View Lifecycle

    override func loadView() {
        super.loadView()
        showNoteEditorViewController()
    }

    // MARK: - Initialization

    init(note: Note, navigationController: UINavigationController) {
        self.note = note
        self.inheritedNavigationController = navigationController
        super.init()
    }
}
