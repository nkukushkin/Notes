import Foundation

struct Note {
    var icon: String
    var title: String
    var body: String

    var id: UUID
    var dateOfCreation: Date
    var dateOfLastModification: Date

    init(
        icon: String, title: String, body: String,
        id: UUID = UUID(),
        dateOfCreation: Date = Date(),
        dateOfLastModification: Date = Date()
    ) {
        self.icon = icon
        self.title = title
        self.body = body

        self.id = id
        self.dateOfCreation = dateOfCreation
        self.dateOfLastModification = dateOfLastModification
    }
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
