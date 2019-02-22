import UIKit

class NoteEditorEmojiButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .red

        titleLabel?.font = .systemFont(ofSize: 60)
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
