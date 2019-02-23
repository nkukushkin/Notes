import UIKit

class NoteEditorTitleTextView: NKTextView {
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        backgroundColor = .green

        placeholder = LocalizedStrings.noteTitlePlaceholder
        font = UIFont.preferredFont(forTextStyle: .title1)
            // We know that the system font supports `traitBold`
            .withSymbolicTraits(.traitBold)!
        isScrollEnabled = false
        returnKeyType = .continue

        layoutMargins.left = 0
        layoutMargins.right = 0
        preservesSuperviewLayoutMargins = true
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
}
