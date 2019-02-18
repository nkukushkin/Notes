import UIKit

class EmojiCollectionViewCell: UICollectionViewCell {

    static let reuseIdentifier = "EmojiCollectionViewCell"

    var emoji: String? {
        didSet { updateUserInterface() }
    }

    private lazy var emojiLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 50)
        return label
    }()

    private func setupUserInterface() {
        contentView.embedSubview(emojiLabel)
    }

    private func updateUserInterface() {
        emojiLabel.text = emoji
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUserInterface()
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
