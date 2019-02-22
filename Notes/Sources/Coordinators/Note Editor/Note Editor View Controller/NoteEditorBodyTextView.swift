import UIKit

class NoteEditorBodyTextView: NKTextView {
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        backgroundColor = .blue

        placeholder = "Empty note."
        font = .preferredFont(forTextStyle: .body)
        isScrollEnabled = false
        
        preservesSuperviewLayoutMargins = true
        layoutMargins = .zero
    }
}

#warning("TODO: Localized Strings")
