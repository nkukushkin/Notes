import UIKit

protocol NoteEditorViewDelegate: class {
    func noteEditorViewDidTapEmoji(noteEditor: NoteEditorView)
    func noteEditorView(noteEditorView: NoteEditorView, didChangeNoteTitle: String)
    func noteEditorView(noteEditorView: NoteEditorView, didChangeNoteBody: String)
}

class NoteEditorView: UIView {
    weak var delegate: NoteEditorViewDelegate?

    func setNote(_ note: Note) {
        emojiButton.setTitle(note.emoji, for: .normal)
        titleTextView.text = note.title
        bodyTextView.text = note.body
    }

    // MARK: - Actions

    @objc
    private func emojiButtonTapped() {
        delegate?.noteEditorViewDidTapEmoji(noteEditor: self)
    }

    private func setupActions() {
        emojiButton.addTarget(self, action: #selector(emojiButtonTapped), for: .touchUpInside)
        titleTextView.delegate = self
        bodyTextView.delegate = self
    }

    // MARK: - User Interface

    private enum Constants {
        static let verticalSpacing: CGFloat = 8
    }

    private let emojiButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = .systemFont(ofSize: 50)
        return button
    }()

    private let titleTextView: NKTextView = {
        let textView = NKTextView()
        textView.isScrollEnabled = false
        textView.font = UIFont.preferredFont(forTextStyle: .title1)
            // We know that the system font supports `traitBold`
            .withSymbolicTraits(.traitBold)!
        textView.placeholder = LocalizedStrings.noteTitlePlaceholder
        textView.returnKeyType = .continue
        return textView
    }()

    private let bodyTextView: NKTextView = {
        let textView = NKTextView()
        textView.isScrollEnabled = false
        textView.font = .preferredFont(forTextStyle: .body)
        textView.placeholder = LocalizedStrings.noteBodyPlaceholder
        return textView
    }()

    private let stackForTextViews: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = Constants.verticalSpacing
        return stackView
    }()

    private func setupUserInterface() {
        layoutMargins.top = Constants.verticalSpacing

        emojiButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(emojiButton)

        titleTextView.preservesSuperviewLayoutMargins = true
        bodyTextView.preservesSuperviewLayoutMargins = true

        stackForTextViews.addArrangedSubviews([titleTextView, bodyTextView])
        stackForTextViews.preservesSuperviewLayoutMargins = true
        stackForTextViews.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackForTextViews)

        NSLayoutConstraint.activate([
            layoutMarginsGuide.leadingAnchor.constraint(equalTo: emojiButton.leadingAnchor),
            layoutMarginsGuide.topAnchor.constraint(equalTo: emojiButton.topAnchor),

            emojiButton.bottomAnchor.constraint(equalTo: stackForTextViews.topAnchor),

            leadingAnchor.constraint(equalTo: stackForTextViews.leadingAnchor),
            stackForTextViews.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackForTextViews.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])

        emojiButton.setContentHuggingPriority(.defaultHigh + 2, for: .vertical)
        titleTextView.setContentHuggingPriority(.defaultHigh + 1, for: .vertical)
        bodyTextView.setContentHuggingPriority(.defaultHigh, for: .vertical)
    }

    // MARK: - Initialization

    init() {
        super.init(frame: .zero)
        setupUserInterface()
        setupActions()
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - UITextViewDelegate

extension NoteEditorView: UITextViewDelegate {
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
            let title = textView.text ?? ""
            delegate?.noteEditorView(noteEditorView: self, didChangeNoteTitle: title)
        case bodyTextView:
            let body = textView.text ?? ""
            delegate?.noteEditorView(noteEditorView: self, didChangeNoteBody: body)
        default:
            fatalError("Invalid textView: \(textView)!")
        }
    }
}

// MARK: - Localized Strings

private enum LocalizedStrings {
    static var noteTitlePlaceholder: String {
        return NSLocalizedString(
            "Untitled",
            comment: "Placeholder for the field where user can edit note title."
        )
    }

    static var noteBodyPlaceholder: String {
        return NSLocalizedString(
            "Write your note here…",
            comment: "Placeholder for the field where user can edit note body."
        )
    }
}
