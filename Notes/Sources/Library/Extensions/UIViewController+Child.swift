import UIKit

extension UIViewController {
    /// Adds child view controller and its view into the hierarchy.
    ///
    /// View controllers can have only one parent.
    /// If the child already has a parent and that parent is not the receiver,
    /// this method removes the previous parent before making the receiver its new parent.
    ///
    /// - Parameters:
    ///   - child: View controller to be added as a child.
    ///   - addChildView: Closure that should add child’s view into the view hierarchy.
    func addChild(_ child: UIViewController, addChildView: (UIView) -> Void) {
        if child.parent != self {
            child.removeFromParentAndItsView()
            addChild(child)
            addChildView(child.view)
            child.didMove(toParent: self)
        } else {
            addChildView(child.view)
        }
    }

    /// Adds a child view controller and embeds its view, binding its edges
    /// to the edges of the given container.
    func embedChild(_ child: UIViewController, in container: UIView) {
        addChild(child, addChildView: { childView in
            childView.frame = container.bounds
            childView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            container.addSubview(childView)
        })
    }

    func removeFromParentAndItsView() {
        willMove(toParent: nil)
        viewIfLoaded?.removeFromSuperview()
        removeFromParent()
    }
}
