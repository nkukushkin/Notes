import UIKit

class EmojiPickerViewController: UICollectionViewController {
    private let emojis: [String] = allEmojis

    var didPickEmojiHandler: ((String) -> Void)?

    private func configureCollectionView() {
        collectionView.backgroundColor = .white
        collectionView.alwaysBounceVertical = true
        collectionView.preservesSuperviewLayoutMargins = true
        collectionView.register(
            EmojiCollectionViewCell.self,
            forCellWithReuseIdentifier: EmojiCollectionViewCell.reuseIdentifier
        )
    }

    // MARK: - View Lifecycle

    override func loadView() {
        super.loadView()
        configureCollectionView()
    }

    // MARK: - Initialization

    init() {
        super.init(collectionViewLayout: EmojiCollectionViewLayout())
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - UICollectionViewDataSource

extension EmojiPickerViewController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return emojis.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: EmojiCollectionViewCell.reuseIdentifier,
            for: indexPath
        ) as! EmojiCollectionViewCell

        let emoji = emojis[indexPath.item]
        cell.emoji = emoji

        return cell
    }
}

// MARK: - UICollectionViewDelegate

extension EmojiPickerViewController {
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let emoji = emojis[indexPath.item]
        didPickEmojiHandler?(emoji)
    }
}
