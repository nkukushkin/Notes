class RandomNoteGenerator {
    private let emojis = [
        "💩",
        "👻",
        "😻",
        "🙌",
        "👆",
        "🐷",
        "🐽",
        "💡",
        "👺",
        "🎃",
        "🥾",
        "💪",
        "🥞",
        "❤️"
    ]

    private let titles = [
        "Hi",
        "Hello!",
        "I'm a note!",
        "YOLO!",
        "No.",
        "Kek",
        "Subscribe",
        "To",
        "Pewdiepie",
        "Pokémon",
        "FBI",
        "Groceries",
        "To Do",
        "Recommendataions",
        "Note",
        "Sample"
    ]

    private func randomBody() -> String {
        return [String](repeating: "Lorem ipsum. ", count: .random(in: 1...100))
            .joined()
            .trimmingCharacters(in: .whitespaces)
    }

    func generateNote() -> Note {
        let emoji = emojis.randomElement() ?? ""
        let title = titles.randomElement() ?? ""
        let body = randomBody()
        return Note(icon: emoji, title: title, body: body)
    }

    func generateNotes(quantity: Int) -> [Note] {
        guard quantity > 0 else { return [] }
        return (1...quantity).map { _ in generateNote() }
    }
}
