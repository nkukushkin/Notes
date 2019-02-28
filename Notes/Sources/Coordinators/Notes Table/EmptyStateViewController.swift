import UIKit

class EmptyStateViewController: UIViewController {

    var addNoteHandler: (() -> Void)?

    // MARK: - Actions

    @objc
    private func addNoteButtonTapped() {
        addNoteHandler?()
    }

    private func setupActions() {
        addNoteButton.addTarget(self, action: #selector(addNoteButtonTapped), for: .touchUpInside)
    }

    // MARK: - User Interface

    private lazy var label: UILabel = {
        let label = UILabel()
        label.text = LocalizedStrings.zeroNotes
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        label.textAlignment = .center
        return label
    }()

    private lazy var addNoteButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(LocalizedStrings.addNote, for: .normal)
        button.titleLabel?.font = UIFont.preferredFont(forTextStyle: .subheadline)
        return button
    }()

    private func setupUserInterface() {
        view.backgroundColor = .white

        let stack = UIStackView(arrangedSubviews: [label, addNoteButton])
        stack.axis = .vertical

        stack.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stack)
        let guide = view.layoutMarginsGuide
        NSLayoutConstraint.activate(
            stack.edgesAnchor.constraints(lessThanOrEqualTo: guide.edgesAnchor)
            + [
                stack.centerYAnchor.constraint(equalTo: guide.centerYAnchor),
                stack.centerXAnchor.constraint(equalTo: guide.centerXAnchor)
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
            comment: "Title for the screen that tells user that he has no notes."
        )
    }

    static var addNote: String {
        return NSLocalizedString(
            "Compose",
            comment: "Title for button that adds a new note."
        )
    }
}
