import UIKit

class NoteEditorViewController: UIViewController {
    private(set) var note: Note

    func setNote(_ note: Note) {
        self.note = note
        updateUserInterface()
    }

    var didTapEmojiHandler: (() -> Void)?
    var didChangeNoteHandler: ((Note) -> Void)?

    // MARK: - User Interface

    var scrollView: UIScrollView {
        return view as! UIScrollView
    }

    private lazy var noteEditorView: NoteEditorView = NoteEditorView()

    private func updateUserInterface() {
        guard isViewLoaded else { return }
        noteEditorView.setNote(note)
    }

    // MARK: - View Lifecycle

    override func loadView() {
        view = UIScrollView()
        scrollView.backgroundColor = .white
        scrollView.keyboardDismissMode = .interactive
        scrollView.alwaysBounceVertical = true

        noteEditorView.preservesSuperviewLayoutMargins = true
        scrollView.embedSubview(noteEditorView)
        noteEditorView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        noteEditorView.heightAnchor.constraint(
            greaterThanOrEqualTo: scrollView.layoutMarginsGuide.heightAnchor
        ).isActive = true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        updateUserInterface()
        noteEditorView.delegate = self
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        registerForKeyboardNotifications()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        unregisterFromKeyboardNotifications()
    }

    // MARK: - Initialization

    init(note: Note) {
        self.note = note
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - NoteEditorViewDelegate

extension NoteEditorViewController: NoteEditorViewDelegate {
    func noteEditorViewDidTapEmoji(noteEditor: NoteEditorView) {
        didTapEmojiHandler?()
    }

    func noteEditorView(noteEditorView: NoteEditorView, didChangeNoteBody body: String) {
        note.body = body
        didChangeNoteHandler?(note)
    }

    func noteEditorView(noteEditorView: NoteEditorView, didChangeNoteTitle title: String) {
        note.title = title
        didChangeNoteHandler?(note)
    }
}

// MARK: - Keyboard Observation

extension NoteEditorViewController {
    private var keyboardNotificationNames: [Notification.Name] {
        return [
            UIResponder.keyboardWillShowNotification,
            UIResponder.keyboardWillHideNotification,
            UIResponder.keyboardWillChangeFrameNotification
        ]
    }

    @objc
    func handleKeyboardNotification(notification: Notification) {
        guard
            let userInfo = notification.userInfo,
            let keyboardFrameEnd = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect
            else { return }

        let bottomInset = keyboardFrameEnd.height - view.layoutMargins.bottom
        print("\(notification.name)")
        print("bottom inset: \(bottomInset)")

        scrollView.contentInset.bottom = bottomInset
        scrollView.scrollIndicatorInsets.bottom = bottomInset
    }

    private func registerForKeyboardNotifications() {
        for name in keyboardNotificationNames {
            NotificationCenter.default.addObserver(
                self,
                selector: #selector(handleKeyboardNotification(notification:)),
                name: name,
                object: nil
            )
        }
    }

    private func unregisterFromKeyboardNotifications() {
        for name in keyboardNotificationNames {
            NotificationCenter.default.removeObserver(self, name: name, object: nil)
        }
    }
}
