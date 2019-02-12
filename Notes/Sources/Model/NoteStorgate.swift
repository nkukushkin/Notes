protocol NoteStorage {
    /// Saves a new note if its ID is new,
    /// overwrites existing note with this ID otherwise.
    func save(note: Note)
    func delete(note: Note)
    func loadAllNotes() -> Set<Note>
}
