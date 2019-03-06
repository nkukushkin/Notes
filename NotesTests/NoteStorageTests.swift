import XCTest
@testable import Notes

class NoteStorageTests: XCTestCase {
    func testSavingNotesWithSameIdentity() {
        let mockPersistenceService = MockPersistenceService()
        let notesStorage = PersistedNoteStorage(persistenceService: mockPersistenceService)

        var note = Note(icon: "1", title: "1", body: "1")
        notesStorage.save(note: note)
        note.body = "2" // changes the note, but preserves identity (id)
        notesStorage.save(note: note)

        let storageNote = notesStorage.notes.value.first!
        let persistedNote = mockPersistenceService.model!.first!
        XCTAssert(note == storageNote)
        XCTAssert(note == persistedNote)
    }
}
