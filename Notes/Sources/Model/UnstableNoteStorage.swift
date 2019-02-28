import Foundation

class UnstableNoteStorage: NoteStorage {
    private let timer = TimerController(interval: Constants.mutationInterval, repeats: true)
    private let noteGenerator: RandomNoteGenerator

    private enum Constants {
        static let maxNotes = 1
        static let mutationInterval: TimeInterval = 4
    }

    // MARK: - Actions

    private func addRandomNotes() {
        let max = Constants.maxNotes - notes.count
        let randomNotes = noteGenerator.generateNotes(quantity: .random(in: 1...max))
        save(notes: randomNotes)
    }

    private func deleteRandomNote() {
        if let note = notes.randomElement() {
            delete(note: note)
        }
    }

    private func peformRandomMutation() {
        if notes.isEmpty {
            addRandomNotes()
        } else if notes.count >= Constants.maxNotes {
            deleteRandomNote()
        } else if let randomMutation = [addRandomNotes, deleteRandomNote].randomElement() {
            randomMutation()
        }
    }

    // MARK: - Initialization

    init(noteGenerator: RandomNoteGenerator) {
        self.noteGenerator = noteGenerator
        super.init()
        addRandomNotes()
        timer.schedule { [weak self] in
            self?.peformRandomMutation()
        }
    }

    deinit {
        timer.invalidate()
    }
}
