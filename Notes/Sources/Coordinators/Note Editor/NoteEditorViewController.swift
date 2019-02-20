import UIKit

class NoteEditorIconButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .red
        titleLabel?.font = .systemFont(ofSize: 50)
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class NoteEditorTitleTextView: EmbeddableTextView {
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        backgroundColor = .red
        preservesSuperviewLayoutMargins = true
        isScrollEnabled = false
        font = .preferredFont(forTextStyle: .title1)
    }
}

class NoteEditorBodyTextView: EmbeddableTextView {
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        backgroundColor = .red
        preservesSuperviewLayoutMargins = true
        isScrollEnabled = false
        font = .preferredFont(forTextStyle: .body)
    }
}

class NoteEditorViewController: UIViewController {

    private(set) var note: Note

    func setNote(_ note: Note) {
        self.note = note
        updateUserInterface()
    }

    var didTapEmojiHandler: (() -> Void)?
    var didChangeNoteHandler: ((Note) -> Void)?

    private func updateUserInterface() {
        iconButton.setTitle(note.emoji, for: .normal)
        titleTextView.text = note.title
        bodyTextView.text = note.body
    }

    private lazy var iconButton = NoteEditorIconButton()
    private lazy var titleTextView = NoteEditorTitleTextView()
    private lazy var bodyTextView = NoteEditorBodyTextView()

    override func loadView() {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .white
        scrollView.preservesSuperviewLayoutMargins = true
        scrollView.keyboardDismissMode = .interactive
        scrollView.alwaysBounceVertical = true
        view = scrollView

        let buttonStackView = UIStackView(arrangedSubviews: [iconButton])
        buttonStackView.preservesSuperviewLayoutMargins = true
        buttonStackView.isLayoutMarginsRelativeArrangement = true
        buttonStackView.axis = .vertical
        buttonStackView.alignment = .leading

        let mainStackView = UIStackView()
        mainStackView.preservesSuperviewLayoutMargins = true
        mainStackView.axis = .vertical

        mainStackView.addArrangedSubview(buttonStackView)
        mainStackView.addArrangedSubview(titleTextView)
        mainStackView.setCustomSpacing(15, after: titleTextView)
        mainStackView.addArrangedSubview(bodyTextView)

        scrollView.embedSubview(mainStackView)
        mainStackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true

        setupActions()
    }

    // MARK: Actions

    @objc
    private func emojiButtonTapped() {
        didTapEmojiHandler?()
    }

    private func setupActions() {
        iconButton.addTarget(self, action: #selector(emojiButtonTapped), for: .touchUpInside)
        titleTextView.delegate = self
        bodyTextView.delegate = self
    }

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        updateUserInterface()
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
