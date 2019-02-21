import UIKit

extension UIViewController {
    static func swizzleLifecycleLogging() {
        let swizzleSelectorPairs = [
            (#selector(swizzled_loadView), #selector(loadView)),
            (#selector(swizzled_viewDidLoad), #selector(viewDidLoad)),
            (#selector(swizzled_viewWillAppear(_:)), #selector(viewWillAppear(_:))),
            (#selector(swizzled_viewDidAppear(_:)), #selector(viewDidAppear(_:))),
            (#selector(swizzled_viewWillDisappear(_:)), #selector(viewWillDisappear(_:))),
            (#selector(swizzled_viewDidDisappear(_:)), #selector(viewDidDisappear(_:)))
        ]

        for (swizzled, original) in swizzleSelectorPairs {
            exchangeImplementations(swizzled, original, areClassSelectors: false, for: self)
        }
    }
}

// MARK: - Lifecycle Logging

@objc
private extension UIViewController {
    func swizzled_loadView() {
        swizzled_loadView()
        print("\(self) \(#function)")
    }

    func swizzled_viewDidLoad() {
        swizzled_viewDidLoad()
        print("\(self) \(#function)")
    }

    func swizzled_viewWillAppear(_ animated: Bool) {
        swizzled_viewWillAppear(animated)
        print("\(self) \(#function)(animated: \(animated))")
    }

    func swizzled_viewDidAppear(_ animated: Bool) {
        swizzled_viewDidAppear(animated)
        print("\(self) \(#function)(animated: \(animated))")
    }

    func swizzled_viewWillDisappear(_ animated: Bool) {
        swizzled_viewWillDisappear(animated)
        print("\(self) \(#function)(animated: \(animated))")
    }

    func swizzled_viewDidDisappear(_ animated: Bool) {
        swizzled_viewDidDisappear(animated)
        print("\(self) \(#function)(animated: \(animated))")
    }
}
