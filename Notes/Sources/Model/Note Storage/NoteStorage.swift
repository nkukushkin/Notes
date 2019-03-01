protocol NoteStorage {
    var notes: Observable<Set<Note>> { get }

    func save(note: Note)
    func delete(note: Note)
}
