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

// MARK: - Equatable

extension Note: Equatable {}

// MARK: - Codable

extension Note: Codable {}
