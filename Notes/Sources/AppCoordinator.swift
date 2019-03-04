import UIKit

class AppCoordinator {
    private lazy var window = UIWindow()

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

    private lazy var noteStorage: NoteStorage = {
        return PersistedNoteStorage(persistenceService: notesPersistenceService)
    }()

    func launch() {
        let notesCoordinator = NotesCoordinator(noteStorage: noteStorage)

        window.rootViewController = notesCoordinator
        window.makeKeyAndVisible()
    }
}

