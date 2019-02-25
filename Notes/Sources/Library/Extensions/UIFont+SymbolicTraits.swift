import UIKit

extension UIFont {
    /// Returns a new font in the same family with the given symbolic traits,
    /// or `nil` if none found in the system.
    func withSymbolicTraits(_ traits: UIFontDescriptor.SymbolicTraits) -> UIFont? {
        guard let descriptorWithTraits = fontDescriptor.withSymbolicTraits(traits)
            else { return nil }
        return UIFont(descriptor: descriptorWithTraits, size: 0)
    }
}
