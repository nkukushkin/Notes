class PersistedNoteStorage: NoteStorage {
    private let persistenceService: PersistenceService

    // Though it’s declated as `let`, this
    // observable can be updated from the outside.
    let notes: Observable<[Note]>

    /// Saving notes with same IDs will overwrite them.
    func save(note: Note) {
        var mutableNotes = notes.value

        if let existingIndex = mutableNotes.firstIndex(where: { $0.id == note.id }) {
            let existingNote = mutableNotes[existingIndex]
            if existingNote != note {
                mutableNotes[existingIndex] = note
            } else {
                return // nothing changed
            }
        } else {
            mutableNotes.append(note)
        }

        notes.update(mutableNotes)
    }

    func delete(note: Note) {
        var mutableNotes = notes.value
        mutableNotes.removeAll(where: { $0.id == note.id })
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

        let initialValue = persistenceService.load() ?? [Note]()
        notes = Observable(initialValue: initialValue)
        observeNotes()
    }
}
