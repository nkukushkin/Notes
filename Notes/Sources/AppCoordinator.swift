import UIKit

class AppCoordinator {
    private lazy var window = UIWindow()
    private lazy var dependencies = AppDependencies()

    func launch() {
        let notesCoordinator = NotesCoordinator(
            noteStorage: dependencies.noteStorage
        )

        window.rootViewController = notesCoordinator
        window.makeKeyAndVisible()
    }
}

