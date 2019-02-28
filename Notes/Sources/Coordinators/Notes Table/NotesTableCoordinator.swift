import UIKit

/*
 NotesTableCoordinator swaps between NotesTableViewController
 and EmptyStateViewController, depending on whether there are any notes to show.
 */
class NotesTableCoordinator: Coordinator {
    var notes: [Note] {
        didSet {
            guard isViewLoaded else { return }
            updateShownViewController()
        }
    }

    var noteSelectedHanlder: ((Note) -> Void)? {
        didSet {
            notesTableViewController?.noteSelectedHanlder = noteSelectedHanlder
        }
    }

    var addNewNoteHandler: (() -> Void)? {
        didSet {
            emptyStateViewController?.addNewNoteHandler = addNewNoteHandler
        }
    }

    private weak var shownViewController: UIViewController!

    // Since we don’t hold any strong references to embedded view controllers,
    // once the `removeChildAndItsView(_:)` method is called, they are released from memory.
    private func updateShownViewController() {
        if let notesTableViewController = notesTableViewController {
            if notes.isEmpty {
                removeChildAndItsView(notesTableViewController)
                showEmptyStateViewController()
            } else {
                notesTableViewController.notes = notes
            }
        } else if let emptyStateViewController = emptyStateViewController {
            if !notes.isEmpty {
                removeChildAndItsView(emptyStateViewController)
                showNotesTableViewController()
            }
        } else {
            if notes.isEmpty {
                showEmptyStateViewController()
            } else {
                showNotesTableViewController()
            }
        }
    }

    // MARK: - Notes Table

    private var notesTableViewController: NotesTableViewController? {
        return shownViewController as? NotesTableViewController
    }

    func showNotesTableViewController() {
        let notesTableViewController = NotesTableViewController(notes: notes)
        notesTableViewController.noteSelectedHanlder = noteSelectedHanlder

        shownViewController = notesTableViewController
        embedChild(notesTableViewController, in: view)
    }

    // MARK: - Empty State

    private var emptyStateViewController: EmptyStateViewController? {
        return shownViewController as? EmptyStateViewController
    }

    func showEmptyStateViewController() {
        let emptyStateViewController = EmptyStateViewController()
        emptyStateViewController.addNewNoteHandler = addNewNoteHandler

        shownViewController = emptyStateViewController
        embedChild(emptyStateViewController, in: view)
    }

    // MARK: - View Lifecycle

    override func loadView() {
        super.loadView()
        updateShownViewController()
    }

    // MARK: - Initialization

    init(notes: [Note]) {
        self.notes = notes
        super.init()
    }
}
