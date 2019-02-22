import Foundation

extension String {
    /// Returns `false` for empty strings.
    func allCharactersAre(_ characterSet: CharacterSet) -> Bool {
        guard !isEmpty else { return false }
        return self
            .flatMap { $0.unicodeScalars }
            .allSatisfy { characterSet.contains($0) }
    }
}
