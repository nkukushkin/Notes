class RandomNoteGenerator {
    private let randomEmoji = [
        "💩",
        "👻",
        "😻",
        "🙌",
        "🚘",
        "🎰",
        "🐽",
        "💡"
    ]

    private let randomTitles = [
        "Hi",
        "Hello",
        "Title",
        "I'm a note!",
        "YOLO!",
        "No."
    ]

    private let randomBodies = [
        "Hi",
        "Hello",
        "Title",
        "I'm a note!",
        "YOLO!",
        "No."
    ]

    func generateRandomNote() -> Note {
        let emoji = randomEmoji.randomElement() ?? ""
        let title = randomTitles.randomElement() ?? ""
        let body = randomBodies.randomElement() ?? ""
        return Note(icon: emoji, title: title, body: body)
    }

    func generateRandomNotes(quantity: Int) -> [Note] {
        guard quantity > 0 else { return [] }
        return (1...quantity).map { _ in
            generateRandomNote()
        }
    }
}
