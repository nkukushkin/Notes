import UIKit

class NoteEditorTitleTextView: NKTextView {
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        backgroundColor = .green

        placeholder = "Untitled"
        font = .boldTitle1
        isScrollEnabled = false
        returnKeyType = .continue

        layoutMargins = .zero
        preservesSuperviewLayoutMargins = true
    }
}

#warning("TODO: Localized Strings")

// MARK: UIFont + Bold Title1

private extension UIFont {
    static var boldTitle1: UIFont {
        let descriptor = UIFontDescriptor.preferredFontDescriptor(withTextStyle: .title1)
        let boldDescriptor = descriptor.withSymbolicTraits(.traitBold)! // we know that system font has this trait
        return UIFont(descriptor: boldDescriptor, size: 0)
    }
}
