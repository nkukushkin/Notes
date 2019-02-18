import UIKit

/// UITextView subclass that positions its text using layoutMargins.
class EmbeddableTextView: UITextView {
    private func setup() {
        textContainer.lineFragmentPadding = 0
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        textContainerInset = layoutMargins
    }

    // MARK: Initialization

    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        setup()
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
