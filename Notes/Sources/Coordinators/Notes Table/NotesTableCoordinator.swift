import UIKit

/*
 NotesTableCoordinator swaps between NotesTableViewController
 and EmptyStateViewController, depending on whether there are any notes to show.
 */
class NotesTableCoordinator: Coordinator {
    enum ViewData {
        case empty
        case notes([Note])

        init(notes: [Note]) {
            if notes.isEmpty {
                self = .empty
            } else {
                let sortedNotes = notes
                    .sorted { $0.dateOfCreation > $1.dateOfCreation }
                self = .notes(sortedNotes)
            }
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

    private weak var embeddedViewController: UIViewController! {
        didSet {
            oldValue?.removeFromParentAndItsView()
        }
    }

    private func updateShownViewController() {
        switch viewData {
        case let .notes(notes):
            if let notesTableViewController = embeddedViewController as? NotesTableViewController {
                notesTableViewController.notes = notes
            } else {
                showNotesTableViewController(with: notes)
            }
        case .empty:
            if !(embeddedViewController is EmptyStateViewController) {
                showEmptyStateViewController()
            }
        }
    }

    // MARK: - Notes Table

    private var notesTableViewController: NotesTableViewController? {
        return embeddedViewController as? NotesTableViewController
    }

    func showNotesTableViewController(with notes: [Note]) {
        let notesTableViewController = NotesTableViewController(notes: notes)
        notesTableViewController.noteSelectedHanlder = noteSelectedHanlder
        notesTableViewController.noteDeletedHandler = noteDeletedHandler

        embeddedViewController = notesTableViewController
        embedChild(notesTableViewController, in: view)
    }

    // MARK: - Empty State

    private var emptyStateViewController: EmptyStateViewController? {
        return embeddedViewController as? EmptyStateViewController
    }

    func showEmptyStateViewController() {
        let emptyStateViewController = EmptyStateViewController()
        emptyStateViewController.addNewNoteHandler = addNewNoteHandler

        embeddedViewController = emptyStateViewController
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
