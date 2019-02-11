import UIKit

private let noteCellIdentifier = "NoteCell"

class NoteListViewController: UITableViewController {

    private let notes: [Note]

    private func registerTableViewCells() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: noteCellIdentifier)
    }

    // MARK: Lifecycle

    init(notes: [Note]) {
        self.notes = notes
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        registerTableViewCells()
    }
}

// MARK: - UITableViewDataSource

extension NoteListViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let note = notes[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: noteCellIdentifier, for: indexPath)

        cell.textLabel?.text = "\(note.icon) \(note.title) \(note.body)"

        return cell
    }
}
