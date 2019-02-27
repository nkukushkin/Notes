import UIKit

class EdgesAnchor {
    let leadingAnchor: NSLayoutXAxisAnchor
    let topAnchor: NSLayoutYAxisAnchor
    let trailingAnchor: NSLayoutXAxisAnchor
    let bottomAnchor: NSLayoutYAxisAnchor

    func constraints(equalTo other: EdgesAnchor, constants: UIEdgeInsets = .zero) -> [NSLayoutConstraint] {
        return [
            leadingAnchor.constraint(equalTo: other.leadingAnchor, constant: constants.left),
            topAnchor.constraint(equalTo: other.topAnchor, constant: constants.top),
            trailingAnchor.constraint(equalTo: other.trailingAnchor, constant: constants.right),
            bottomAnchor.constraint(equalTo: other.bottomAnchor, constant: constants.bottom)
        ]
    }

    func constraints(greaterThanOrEqualTo other: EdgesAnchor, constants: UIEdgeInsets = .zero) -> [NSLayoutConstraint] {
        return [
            leadingAnchor.constraint(greaterThanOrEqualTo: other.leadingAnchor, constant: constants.left),
            topAnchor.constraint(greaterThanOrEqualTo: other.topAnchor, constant: constants.top),
            trailingAnchor.constraint(greaterThanOrEqualTo: other.trailingAnchor, constant: constants.right),
            bottomAnchor.constraint(greaterThanOrEqualTo: other.bottomAnchor, constant: constants.bottom)
        ]
    }

    func constraints(lessThanOrEqualTo other: EdgesAnchor, constants: UIEdgeInsets = .zero) -> [NSLayoutConstraint] {
        return [
            leadingAnchor.constraint(lessThanOrEqualTo: other.leadingAnchor, constant: constants.left),
            topAnchor.constraint(lessThanOrEqualTo: other.topAnchor, constant: constants.top),
            trailingAnchor.constraint(lessThanOrEqualTo: other.trailingAnchor, constant: constants.right),
            bottomAnchor.constraint(lessThanOrEqualTo: other.bottomAnchor, constant: constants.bottom)
        ]
    }

    // MARK: - Initialization

    init(
        leadingAnchor: NSLayoutXAxisAnchor,
        topAnchor: NSLayoutYAxisAnchor,
        trailingAnchor: NSLayoutXAxisAnchor,
        bottomAnchor: NSLayoutYAxisAnchor
    ) {
        self.leadingAnchor = leadingAnchor
        self.topAnchor = topAnchor
        self.trailingAnchor = trailingAnchor
        self.bottomAnchor = bottomAnchor
    }
}

// MARK: - UIView + Edge Anchor

extension UIView {
    var edgesAnchor: EdgesAnchor {
        return EdgesAnchor(
            leadingAnchor: leadingAnchor,
            topAnchor: topAnchor,
            trailingAnchor: trailingAnchor,
            bottomAnchor: bottomAnchor
        )
    }
}

// MARK: - UILayoutGuide + Edge Anchor

extension UILayoutGuide {
    var edgesAnchor: EdgesAnchor {
        return EdgesAnchor(
            leadingAnchor: leadingAnchor,
            topAnchor: topAnchor,
            trailingAnchor: trailingAnchor,
            bottomAnchor: bottomAnchor
        )
    }
}
