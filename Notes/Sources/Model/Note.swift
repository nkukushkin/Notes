import Foundation

struct Note {
    let id: UUID
    let dateOfCreation: Date

    var emoji: String
    var title: String
    var body: String

    init(id: UUID = UUID(), dateOfCreation: Date = Date(), icon: String, title: String, body: String) {
        self.id = id
        self.dateOfCreation = dateOfCreation

        self.emoji = icon
        self.title = title
        self.body = body
    }
}

// MARK: - Equatable (Identity)

extension Note: Equatable {
    public static func == (lhs: Note, rhs: Note) -> Bool {
        return lhs.id == rhs.id
    }
}

// MARK: - Hashable

extension Note: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

// MARK: - Codable

extension Note: Codable {}
