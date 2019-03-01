@testable import Notes

extension Note {
    func areContentsEqual(to other: Note) -> Bool {
        return dateOfCreation == other.dateOfCreation
            && emoji == other.emoji
            && title == other.title
            && body == other.body
    }

    func isEqualIdentityAndContents(to other: Note) -> Bool {
        return self == other && areContentsEqual(to: other)
    }
}
