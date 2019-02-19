import Foundation

class UnstableNoteStorage: NoteStorage {
    private let timer: TimerController
    private let sampleNoteGenerator: RandomNoteGenerator

    private enum Constants {
        static let maxNotes = 5
        static let mutationInterval: TimeInterval = 3
    }

    // MARK: Actions

    private func addRandomNotes() {
        let max = Constants.maxNotes - notes.count
        let randomNotes = sampleNoteGenerator.generateRandomNotes(quantity: .random(in: 1...max))
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

    // MARK: Initialization

    init(sampleNoteGenerator: RandomNoteGenerator) {
        self.sampleNoteGenerator = sampleNoteGenerator
        timer = TimerController(interval: Constants.mutationInterval, repeats: true)

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
