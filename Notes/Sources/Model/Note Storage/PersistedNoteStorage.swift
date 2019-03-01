class PersistedNoteStorage: NoteStorage {
    private let persistenceService: PersistenceService

    let notes: Observable<Set<Note>>

    func save(note: Note) {
        var mutableNotes = notes.value
        mutableNotes.remove(note) // Sets don’t replace items
        mutableNotes.insert(note) // with the same hash.
        notes.update(mutableNotes)
    }

    func delete(note: Note) {
        var mutableNotes = notes.value
        mutableNotes.remove(note)
        notes.update(mutableNotes)
    }

    // MARK: - Observation

    private var notesObservationToken: ScopedObservationToken?

    private func observeNotes() {
        notesObservationToken = notes.observe { [weak self] _, newNotes in
            self?.persistenceService.save(newNotes)
        }
    }

    // MARK: - Initialization

    init(persistenceService: PersistenceService) {
        self.persistenceService = persistenceService

        let initialValue = persistenceService.load() ?? Set<Note>()
        notes = Observable(initialValue: initialValue)
        observeNotes()
    }
}
