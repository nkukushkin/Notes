import UIKit

/*
 NotesTableCoordinator swaps between NotesTableViewController
 and EmptyStateViewController, depending on whether there are any notes to show.
 */
class NotesTableCoordinator: Coordinator {
    struct ViewData {
        let notes: [Note]

        enum Mode {
            case emptyState
            case notesTable
        }

        var mode: Mode {
            return notes.isEmpty ? .emptyState : .notesTable
        }
    }

    var viewData: ViewData {
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

    var noteDeletedHandler: ((Note) -> Void)? {
        didSet {
            notesTableViewController?.noteDeletedHandler = noteDeletedHandler
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
            switch viewData.mode {
            case .notesTable:
                notesTableViewController.notes = viewData.notes
            case .emptyState:
                removeChildAndItsView(notesTableViewController)
                showEmptyStateViewController()
            }
        } else if let emptyStateViewController = emptyStateViewController {
            switch viewData.mode {
            case .notesTable:
                removeChildAndItsView(emptyStateViewController)
                showNotesTableViewController()
            case .emptyState:
                break // keep showing `emptyStateViewController`
            }
        } else {
            // If we weren’t showing anything — show initial view controller.
            switch viewData.mode {
            case .notesTable:
                showNotesTableViewController()
            case .emptyState:
                showEmptyStateViewController()
            }
        }
    }

    // MARK: - Notes Table

    private var notesTableViewController: NotesTableViewController? {
        return shownViewController as? NotesTableViewController
    }

    func showNotesTableViewController() {
        let notesTableViewController = NotesTableViewController(notes: viewData.notes)
        notesTableViewController.noteSelectedHanlder = noteSelectedHanlder
        notesTableViewController.noteDeletedHandler = noteDeletedHandler

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

    init(viewData: ViewData) {
        self.viewData = viewData
        super.init()
    }
}

// MARK: - ViewData + Set<Note>

extension NotesTableCoordinator.ViewData {
    init(notes: Set<Note>) {
        self.notes = Array(notes)
            .sorted { $0.dateOfCreation > $1.dateOfCreation }
    }
}
