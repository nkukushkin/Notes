class NoteStorage {
    private(set) var notes: [Note] {
        didSet {
            runObservations(oldValue: oldValue, newValue: notes)
        }
    }

    func save(note: Note) {
        if let existingIndex = notes.firstIndex(of: note) {
            notes.remove(at: existingIndex)
            notes.insert(note, at: existingIndex)
        } else {
            notes.append(note)
        }
    }

    func delete(note: Note) {
        if let existingIndex = notes.firstIndex(of: note) {
            notes.remove(at: existingIndex)
        }
    }

    // MARK: Basic Observing

    typealias Observation = (_ oldValue: [Note], _ newValue: [Note]) -> Void

    struct ObservationToken: Hashable {
        let hashValue: Int
    }

    private var observations: [ObservationToken: Observation] = [:]

    private func runObservations(oldValue: [Note], newValue: [Note]) {
        for observation in observations.values {
            observation(oldValue, newValue)
        }
    }

    private var nextObservationTokenHashValue: Int {
        return (observations.keys.map { $0.hashValue }.max() ?? -1) + 1
    }

    func addObservation(_ observation: @escaping Observation) -> ObservationToken {
        let token = ObservationToken(hashValue: nextObservationTokenHashValue)
        observations[token] = observation
        return token
    }

    func removeObservation(for token: ObservationToken) {
        observations[token] = nil
    }

    // MARK: Initialization

    init() {
        notes = sampleNotes
    }
}

#warning("TODO: Remove samples")
private let sampleNotes: [Note] = [
    Note(icon: "😃", title: "Title", body: "Body"),
    Note(icon: "👻", title: "Title", body: "Body"),
    Note(icon: "💩", title: "Title", body: "Body")
]

