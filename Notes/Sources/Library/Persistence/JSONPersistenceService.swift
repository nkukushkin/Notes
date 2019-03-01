import Foundation

class JSONPersistenceService: PersistenceService {
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
    private let location: URL

    func save<Model: Codable>(_ model: Model) {
        // Who has time for error handling?
        let data = try! encoder.encode(model)
        try! data.write(to: location)
    }

    func load<Model: Codable>() -> Model? {
        if let data = try? Data(contentsOf: location) {
            return try? decoder.decode(Model.self, from: data)
        }
        return nil
    }

    // MARK: - Initialization

    required init(location: URL) {
        self.location = location
    }
}
