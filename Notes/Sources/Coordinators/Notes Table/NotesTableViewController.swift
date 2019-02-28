import UIKit

private let noteCellIdentifier = "NoteCell"

class NotesTableViewController: UITableViewController {
    var notes: [Note] {
        didSet {
            tableView.reloadData()
        }
    }

    var noteSelectedHanlder: ((Note) -> Void)?

    // MARK: - View Lifecycle

    private func setupTableView() {
        tableView.tableFooterView = UIView() // remove extra separators
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: noteCellIdentifier)
    }

    override func loadView() {
        super.loadView()
        setupTableView()
    }

    // MARK: - Lifecycle

    init(notes: [Note]) {
        self.notes = notes
        super.init(style: .plain)
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - UITableViewDataSource

extension NotesTableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let note = notes[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: noteCellIdentifier, for: indexPath)

        cell.textLabel?.text = "\(note.emoji) \(note.title)"
        cell.accessoryType = .disclosureIndicator

        return cell
    }
}

// MARK: - UITableViewDelegate

extension NotesTableViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let note = notes[indexPath.row]
        noteSelectedHanlder?(note)
    }
}
