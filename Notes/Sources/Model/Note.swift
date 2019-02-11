import Foundation

struct Note {
    let icon: String
    let title: String
    let body: String

    let id: UUID = UUID()
    let dateOfCreation: Date = Date()
    let dateOfLastModification: Date = Date()
}

// MARK: - Equatable

extension Note: Equatable {
    public static func == (lhs: Note, rhs: Note) -> Bool {
        return lhs.id == rhs.id
    }
}

// MARK: - Hashable

extension Note: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

// MARK: - Codable

extension Note: Codable {}
