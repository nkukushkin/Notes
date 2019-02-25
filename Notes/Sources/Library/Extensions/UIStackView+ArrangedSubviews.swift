import UIKit

extension UIStackView {
    func addArrangedSubviews(_ views: [UIView]) {
        for view in views { addArrangedSubview(view) }
    }

    func removeArrangedSubviews(_ views: [UIView]) {
        for view in views { removeArrangedSubview(view) }
    }
}
