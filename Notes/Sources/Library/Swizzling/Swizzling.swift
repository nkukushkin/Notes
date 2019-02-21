import Foundation

/// Exchanges method implementation for given selectors.
///
/// - Parameters:
///   - selector1: Selector, which method should be exchanged with the method of the second selector.
///   - selector2: Selector, which method should be exchanged with the method of the first selector.
///   - classSelectors: Flag that indicates whether selectors are for class or instance methods.
///   - anyClass: A pointer to a class definition. Pass the class that contains the methods you want to exchange.
func exchangeImplementations(_ selector1: Selector, _ selector2: Selector, classSelectors: Bool, for anyClass: AnyClass) {
    guard
        let method1 = class_getInstanceMethod(anyClass, selector1),
        let method2 = class_getInstanceMethod(anyClass, selector2)
    else { return }

    method_exchangeImplementations(method1, method2)
}
