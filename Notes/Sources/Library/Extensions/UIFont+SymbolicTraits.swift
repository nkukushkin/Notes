import UIKit

extension UIFont {
    /// Returns a new font in the same family with the given symbolic traits,
    /// or `nil` if none found in the system.
    func withSymbolicTraits(_ traits: UIFontDescriptor.SymbolicTraits) -> UIFont? {
        guard let boldDescriptor = fontDescriptor.withSymbolicTraits(traits)
            else { return nil }
        return UIFont(descriptor: boldDescriptor, size: 0)
    }
}
