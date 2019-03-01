import UIKit

extension UIViewController {
    func addChild(_ child: UIViewController, addChildView: (UIView) -> Void) {
        if child.parent != self {
            child.parent?.removeChildAndItsView(child)
            addChild(child)
            addChildView(child.view)
            child.didMove(toParent: self)
        } else {
            addChildView(child.view)
        }
    }

    func embedChild(_ child: UIViewController, in container: UIView) {
        addChild(child, addChildView: { childView in
            childView.translatesAutoresizingMaskIntoConstraints = false
            childView.frame = container.bounds // helps with UIViewController smarts
            container.addSubview(childView)
            NSLayoutConstraint.activate(
                childView.edgesAnchor.constraints(equalTo: container.edgesAnchor)
            )
        })
    }

    func removeChildAndItsView(_ child: UIViewController) {
        guard child.parent == self else { return }
        child.willMove(toParent: nil)
        child.viewIfLoaded?.removeFromSuperview()
        child.removeFromParent()
    }
}
