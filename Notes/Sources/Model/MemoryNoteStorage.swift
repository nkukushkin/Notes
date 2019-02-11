class MemoryNoteStorage: NoteStorage {
    private var storage: Set<Note> = sampleNotes

    func save(note: Note) {
        storage.insert(note)
    }

    func delete(note: Note) {
        storage.remove(note)
    }

    func loadAllNotes() -> Set<Note> {
        return storage
    }
}


private let sampleNotes: Set<Note> = [
    Note(icon: "OK", title: "OK", body: "OK")
]
