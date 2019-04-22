import Foundation

class AppDependencies {
    private lazy var notesPersistenceService: PersistenceService = {
        let fileName = "notes.json"
        let documentsFolder = try! FileManager.default.url(
            for: .documentDirectory,
            in: .userDomainMask,
            appropriateFor: nil,
            create: true
        )
        let url = documentsFolder.appendingPathComponent(fileName)
        return JSONPersistenceService(url: url)
    }()

    lazy var noteStorage: NoteStorage = {
        return PersistedNoteStorage(persistenceService: notesPersistenceService)
    }()
}
