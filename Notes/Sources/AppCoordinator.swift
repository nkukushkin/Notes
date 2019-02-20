import UIKit

class AppCoordinator {

    private lazy var window = UIWindow()

    private lazy var noteStorage = UnstableNoteStorage(noteGenerator: RandomNoteGenerator())

    func launch() {
        let noteListCoordinator = NoteListCoordinator(noteStorage: noteStorage)

        window.rootViewController = noteListCoordinator
        window.makeKeyAndVisible()
    }
}

