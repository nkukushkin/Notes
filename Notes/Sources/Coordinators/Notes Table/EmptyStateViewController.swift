import UIKit

class EmptyStateViewController: UIViewController {

    var addNewNoteHandler: (() -> Void)?

    // MARK: - Actions

    @objc
    private func newNoteButtonTapped() {
        addNewNoteHandler?()
    }

    private func setupActions() {
        newNoteButton.addTarget(self, action: #selector(newNoteButtonTapped), for: .touchUpInside)
    }

    // MARK: - User Interface

    private lazy var label: UILabel = {
        let label = UILabel()
        label.text = LocalizedStrings.zeroNotes
        label.font = UIFont.preferredFont(forTextStyle: .title2)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()

    private lazy var newNoteButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(LocalizedStrings.addNewNote, for: .normal)
        button.titleLabel?.font = UIFont.preferredFont(forTextStyle: .subheadline)
        return button
    }()

    private func setupUserInterface() {
        view.backgroundColor = .white

        let stack = UIStackView(arrangedSubviews: [label, newNoteButton])
        stack.axis = .vertical
        stack.spacing = 4

        stack.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stack)
        let guide = view.layoutMarginsGuide
        NSLayoutConstraint.activate(
            stack.edgesAnchor.constraints(lessThanOrEqualTo: guide.edgesAnchor)
            + [
                stack.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                stack.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            ]
        )
    }

    // MARK: - View Lifecycle

    override func loadView() {
        super.loadView()
        setupUserInterface()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupActions()
    }
}

// MARK: - Localized Strings

private enum LocalizedStrings {
    static var zeroNotes: String {
        return NSLocalizedString(
            "You have 👌 notes",
            comment: "Title for the empty state screen that tells the user that he has no notes."
        )
    }

    static var addNewNote: String {
        return NSLocalizedString(
            "Compose",
            comment: "Title for button on the empty state screen that adds a new note."
        )
    }
}
