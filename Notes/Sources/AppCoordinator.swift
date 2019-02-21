import UIKit

class AppCoordinator {

    private lazy var window = UIWindow()

    private lazy var noteStorage = UnstableNoteStorage(noteGenerator: RandomNoteGenerator())

    func launch() {
        let notesCoordinator = NotesCoordinator(noteStorage: noteStorage)

        window.rootViewController = notesCoordinator
        window.makeKeyAndVisible()
    }
}

