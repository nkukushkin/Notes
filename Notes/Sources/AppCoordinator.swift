import UIKit

class AppCoordinator {

    private lazy var window = UIWindow()

    private lazy var noteStorage = NoteStorage()

    func launch() {
        let noteListCoordinator = NoteListCoordinator(noteStorage: noteStorage)

        window.rootViewController = noteListCoordinator
        window.makeKeyAndVisible()
    }
}

