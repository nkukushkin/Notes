import UIKit

/// TextView that positions its contents using layoutMargins and can show a placeholder.
class NKTextView: UITextView {
    override var text: String! {
        didSet { updatePlaceholderLabel() }
    }

    override var attributedText: NSAttributedString! {
        didSet { updatePlaceholderLabel() }
    }

    override var textAlignment: NSTextAlignment {
        didSet { updatePlaceholderLabel() }
    }

    override var font: UIFont? {
        didSet { updatePlaceholderLabel() }
    }

    // MARK: - Placeholder

    var placeholder: String? = nil {
        didSet { updatePlaceholderLabel() }
    }

    var placeholderColor: UIColor = .applePlaceholderGray {
        didSet { updatePlaceholderLabel() }
    }

    private lazy var placeholderLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()

    private func updatePlaceholderLabel() {
        if let placeholder = placeholder, !placeholder.isEmpty, text.isEmpty {
            placeholderLabel.isHidden = false
            placeholderLabel.text = placeholder

            placeholderLabel.font = font
            placeholderLabel.textColor = placeholderColor
            placeholderLabel.textAlignment = textAlignment
        } else {
            placeholderLabel.isHidden = true
            placeholderLabel.text = nil
        }
    }

    private func setupPlaceholderLabel() {
        placeholderLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(placeholderLabel)
        let guide = layoutMarginsGuide
        NSLayoutConstraint.activate([
            placeholderLabel.leadingAnchor.constraint(equalTo: guide.leadingAnchor),
            guide.trailingAnchor.constraint(greaterThanOrEqualTo: placeholderLabel.trailingAnchor),
            placeholderLabel.topAnchor.constraint(equalTo: guide.topAnchor),
            guide.bottomAnchor.constraint(greaterThanOrEqualTo: placeholderLabel.bottomAnchor)
        ])
    }

    // MARK: - Observation

    @objc
    private func handleTextChangeNotification(_ notification: Notification) {
        if let object = notification.object as? NSObject, object === self {
            updatePlaceholderLabel()
        }
    }

    private func observeTextChanges() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handleTextChangeNotification),
            name: UITextView.textDidChangeNotification,
            object: self
        )
    }

    // MARK: - Margins

    override func layoutMarginsDidChange() {
        super.layoutMarginsDidChange()
        updateTextContinerInsets()
    }

    private func updateTextContinerInsets() {
        textContainerInset = layoutMargins
        invalidateIntrinsicContentSize()
    }

    // MARK: - Initialization

    private func setup() {
        textContainer.lineFragmentPadding = 0 // remove unnecessary padding
        updateTextContinerInsets()
        setupPlaceholderLabel()
        updatePlaceholderLabel()
        observeTextChanges()
    }

    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        setup()
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Default Placeholder Color

private extension UIColor {
    static var applePlaceholderGray: UIColor {
        // From https://stackoverflow.com/a/43346157/1607485
        return UIColor(red: 0.0, green: 0.0, blue: 0.0980392, alpha: 0.22)
    }
}
