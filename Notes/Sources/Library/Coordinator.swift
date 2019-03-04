import UIKit

/*
 All coordinators in this app (except AppCoordinator) are
 subclasses of UIViewController. This allows them to react to
 view lifecycle methods, and be embedded in other view controllers.

 This also solves the problem of memory management, because UIKit
 already knows how to retain and release presented UIViewControllers.
 */
class Coordinator: UIViewController {
    init() {
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
