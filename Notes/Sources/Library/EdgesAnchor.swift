import UIKit

class EdgesAnchor {
    let leadingAnchor: NSLayoutXAxisAnchor
    let topAnchor: NSLayoutYAxisAnchor
    let trailingAnchor: NSLayoutXAxisAnchor
    let bottomAnchor: NSLayoutYAxisAnchor

    func constraints(equalTo other: EdgesAnchor, insets: UIEdgeInsets = .zero) -> [NSLayoutConstraint] {
        return [
            other.leadingAnchor.constraint(equalTo: leadingAnchor, constant: insets.left),
            trailingAnchor.constraint(equalTo: other.trailingAnchor, constant: insets.right),
            other.topAnchor.constraint(equalTo: topAnchor, constant: insets.top),
            bottomAnchor.constraint(equalTo: other.bottomAnchor, constant: insets.bottom)
        ]
    }

    func constraints(greaterThanOrEqualTo other: EdgesAnchor, insets: UIEdgeInsets = .zero) -> [NSLayoutConstraint] {
        return [
            other.leadingAnchor.constraint(greaterThanOrEqualTo: leadingAnchor, constant: insets.left),
            topAnchor.constraint(greaterThanOrEqualTo: other.topAnchor, constant: insets.top),
            other.trailingAnchor.constraint(greaterThanOrEqualTo: trailingAnchor, constant: insets.right),
            bottomAnchor.constraint(greaterThanOrEqualTo: other.bottomAnchor, constant: insets.bottom)
        ]
    }

    func constraints(lessThanOrEqualTo other: EdgesAnchor, insets: UIEdgeInsets = .zero) -> [NSLayoutConstraint] {
        return [
            other.leadingAnchor.constraint(lessThanOrEqualTo: leadingAnchor, constant: insets.left),
            trailingAnchor.constraint(lessThanOrEqualTo: other.trailingAnchor, constant: insets.right),
            other.topAnchor.constraint(lessThanOrEqualTo: topAnchor, constant: insets.top),
            bottomAnchor.constraint(lessThanOrEqualTo: other.bottomAnchor, constant: insets.bottom)
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

// MARK: - UIView + Edges Anchor

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

// MARK: - UILayoutGuide + Edges Anchor

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
