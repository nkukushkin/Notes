import Foundation

extension String {
    func allCharactersAre(_ characterSet: CharacterSet) -> Bool {
        return self
            .flatMap { $0.unicodeScalars }
            .allSatisfy { characterSet.contains($0) }
    }
}
