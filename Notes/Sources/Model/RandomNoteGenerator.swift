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

    private let strings = [
        "Hi",
        "Hello!",
        "I'm a note!",
        "YOLO!",
        "No.",
        "Kek",
        "Lorem ipsum",
        "Subscribe",
        "To",
        "Pewdiepie",
        "Pokèmon",
        "FBI",
        "Groceries",
        "To Do",
        "Recommendataions",
        "Note",
        "Sample"
    ]

    func generateNote() -> Note {
        let emoji = emojis.randomElement() ?? ""
        let title = strings.randomElement() ?? ""
        let body = strings.randomElement() ?? ""
        return Note(icon: emoji, title: title, body: body)
    }

    func generateNotes(quantity: Int) -> [Note] {
        guard quantity > 0 else { return [] }
        return (1...quantity).map { _ in generateNote() }
    }
}
