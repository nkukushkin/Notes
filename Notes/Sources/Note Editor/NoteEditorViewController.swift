import UIKit

class NoteEditorIconAndTitleCell: UITableViewCell {

}



class NoteEditorViewController: UITableViewController {

    private var note: Note

    private enum Constants {
        static let bodyCellIdentifier = "bodyEditorCell"
        static let iconAndTitleCellIdentifier = "iconAndTitle"
    }

    private func registerCells() {
        tableView.register(
            NoteEditorIconAndTitleCell.self,
            forCellReuseIdentifier: Constants.iconAndTitleCellIdentifier
        )
        tableView.register(
            NoteEditorBodyCell.self,
            forCellReuseIdentifier: Constants.bodyCellIdentifier
        )

    }

    // MARK: Lifecycle

    override func loadView() {
        super.loadView()
        registerCells()
    }

    // MARK: Initialization

    init(note: Note) {
        self.note = note
        super.init(style: .grouped)
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - UITableViewDataSource

extension NoteEditorViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(
                withIdentifier: Constants.iconAndTitleCellIdentifier,
                for: indexPath
            )
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(
                withIdentifier: Constants.bodyCellIdentifier,
                for: indexPath
            )
            return cell
        default:
            fatalError("Invalid section index: \(indexPath.section)!")
        }
    }
}

// MARK: - UITableViewDelegate

extension NoteEditorViewController {

}
