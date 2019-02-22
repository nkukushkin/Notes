import UIKit

class NoteEditorViewController: UIViewController {
    private(set) var note: Note

    func setNote(_ note: Note) {
        self.note = note
        updateUserInterface()
    }

    var didTapEmojiHandler: (() -> Void)?
    var didChangeNoteHandler: ((Note) -> Void)?

    private func updateUserInterface() {
        emojiButton.setTitle(note.emoji, for: .normal)
        titleTextView.text = note.title
        bodyTextView.text = note.body
    }

    private lazy var emojiButton = NoteEditorEmojiButton()
    private lazy var titleTextView = NoteEditorTitleTextView()
    private lazy var bodyTextView = NoteEditorBodyTextView()

    override func loadView() {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .white
        scrollView.preservesSuperviewLayoutMargins = true
        scrollView.keyboardDismissMode = .interactive
        scrollView.alwaysBounceVertical = true
        view = scrollView

        let headerStackView = UIStackView(arrangedSubviews: [emojiButton, titleTextView])
        headerStackView.axis = .vertical
        headerStackView.alignment = .leading

        let mainStackView = UIStackView(arrangedSubviews: [headerStackView, bodyTextView])
        mainStackView.preservesSuperviewLayoutMargins = true
        mainStackView.isLayoutMarginsRelativeArrangement = true
        mainStackView.axis = .vertical
        mainStackView.spacing = 10

        emojiButton.setContentHuggingPriority(.defaultHigh + 2, for: .vertical)
        titleTextView.setContentHuggingPriority(.defaultHigh + 1, for: .vertical)
        bodyTextView.setContentHuggingPriority(.defaultLow, for: .vertical)

        scrollView.embedSubview(mainStackView)
        mainStackView.heightAnchor.constraint(greaterThanOrEqualTo: scrollView.layoutMarginsGuide.heightAnchor).isActive = true
        mainStackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true

        setupActions()
    }

    // MARK: Actions

    @objc
    private func emojiButtonTapped() {
        didTapEmojiHandler?()
    }

    private func setupActions() {
        emojiButton.addTarget(self, action: #selector(emojiButtonTapped), for: .touchUpInside)
        titleTextView.delegate = self
        bodyTextView.delegate = self
    }

    // MARK: Keyboard Observing

    private var scrollView: UIScrollView {
        return view as! UIScrollView
    }

    private let keyboardNotificationNames: [Notification.Name] = [
        UIResponder.keyboardWillShowNotification,
        UIResponder.keyboardWillHideNotification,
        UIResponder.keyboardWillChangeFrameNotification
    ]

    @objc func handleKeyboardNotification(notification: Notification) {
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

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        updateUserInterface()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        registerForKeyboardNotifications()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        unregisterFromKeyboardNotifications()
    }

    // MARK: Initialization

    init(note: Note) {
        self.note = note
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - UITextViewDelegate

extension NoteEditorViewController: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        var tappedEnter: Bool {
            return text.allCharactersAre(.newlines)
        }
        var tappedBackspaceOnFirstCharacterPosition: Bool {
            return range == .zero && text.isEmpty
        }

        switch textView {
        case titleTextView where tappedEnter:
            bodyTextView.becomeFirstResponder()
            return false
        case bodyTextView where tappedBackspaceOnFirstCharacterPosition:
            titleTextView.becomeFirstResponder()
            return false
        default:
            return true
        }
    }

    func textViewDidChange(_ textView: UITextView) {
        switch textView {
        case titleTextView:
            note.title = textView.text
        case bodyTextView:
            note.body = textView.text
        default:
            fatalError("Invalid textView: \(textView)!")
        }
        didChangeNoteHandler?(note)
    }
}
