import Foundation
@testable import Notes

class MockPersistenceService: PersistenceService {
    var model: [Note]?

    func save<Model>(_ model: Model) where Model : Decodable, Model : Encodable {
        self.model = model as? [Note]
    }

    func load<Model>() -> Model? where Model : Decodable, Model : Encodable {
        return model as? Model
    }

    convenience init() {
        self.init(url: URL(string: "www.example.com")!)
    }

    required init(url: URL) {}
}
