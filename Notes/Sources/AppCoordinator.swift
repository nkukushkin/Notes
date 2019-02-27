import UIKit

class AppCoordinator {
    private lazy var window = UIWindow()

    private lazy var noteStorage: NoteStorage = {
        #if DEBUG
        return UnstableNoteStorage(noteGenerator: RandomNoteGenerator())
        #else
        return NoteStorage()
        #endif
    }()

    func launch() {
        let notesCoordinator = NotesCoordinator(noteStorage: noteStorage)

        window.rootViewController = notesCoordinator
        window.makeKeyAndVisible()
    }
}

