import UIKit

class NoteEditorBodyTextView: NKTextView {
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        backgroundColor = .blue

        placeholder = LocalizedStrings.noteBodyPlaceholder
        font = .preferredFont(forTextStyle: .body)
        isScrollEnabled = false
        
        layoutMargins.left = 0
        layoutMargins.right = 0
        preservesSuperviewLayoutMargins = true
    }
}

// MARK: - Localized Strings

private enum LocalizedStrings {
    static var noteBodyPlaceholder: String {
        return NSLocalizedString(
            "Write your note here…",
            comment: "Placeholder for the field where user can edit note body."
        )
    }
}
