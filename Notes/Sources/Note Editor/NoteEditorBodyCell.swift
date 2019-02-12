import UIKit

class NoteEditorBodyCell: UITableViewCell {

    var bodyText: String? {
        didSet {
            updateUserInterface()
        }
    }

    private let textViewHeight: CGFloat = 150

    private lazy var textView: EmbeddableTextView = {
        let textView = EmbeddableTextView()
        textView.font = .preferredFont(forTextStyle: .body)
        return textView
    }()

    private func setupUserInterface() {
        preservesSuperviewLayoutMargins = true
        contentView.preservesSuperviewLayoutMargins = true
        textView.preservesSuperviewLayoutMargins = true
        contentView.embedSubview(textView)
        textView.heightAnchor.constraint(equalToConstant: textViewHeight).isActive = true
    }

    private func updateUserInterface() {
        textView.text = bodyText
    }

    // MARK: Initialization

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUserInterface()
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
