import UIKit

class NoteEditorBodyTextView: NKTextView {
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
//        backgroundColor = .blue

        placeholder = "Write your note here…"
        font = .preferredFont(forTextStyle: .body)
        isScrollEnabled = false
        
        layoutMargins.left = 0
        layoutMargins.right = 0
        preservesSuperviewLayoutMargins = true
    }
}

#warning("TODO: Localized Strings")
