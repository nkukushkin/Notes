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

#warning("TODO: Remove samples")
private let sampleNotes: Set<Note> = [
    Note(icon: "😃", title: "Title", body: "Body"),
    Note(icon: "👻", title: "Title", body: "Body"),
    Note(icon: "💩", title: "Title", body: "Body")
]
