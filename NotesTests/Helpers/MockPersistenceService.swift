import Foundation
@testable import Notes

class MockPersistenceService: PersistenceService {
    var model: Set<Note>?

    func save<Model>(_ model: Model) where Model : Decodable, Model : Encodable {
        self.model = model as? Set<Note>
    }

    func load<Model>() -> Model? where Model : Decodable, Model : Encodable {
        return model as? Model
    }

    convenience init() {
        self.init(location: URL(string: "www.example.com")!)
    }

    required init(location: URL) {}
}
