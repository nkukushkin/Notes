import Foundation

struct Note {
    let id: UUID
    var icon: String
    var title: String
    var body: String

    init(id: UUID = UUID(), icon: String, title: String, body: String) {
        self.id = id
        self.icon = icon
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
