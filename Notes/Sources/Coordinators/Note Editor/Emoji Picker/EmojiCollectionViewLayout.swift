import UIKit

class EmojiCollectionViewLayout: UICollectionViewFlowLayout {
    override init() {
        super.init()
        estimatedItemSize = CGSize(width: 50, height: 50)
        sectionInsetReference = .fromLayoutMargins
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
