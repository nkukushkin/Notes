protocol NoteStorage {
    var notes: Observable<[Note]> { get }

    func save(note: Note)
    func delete(note: Note)
}
