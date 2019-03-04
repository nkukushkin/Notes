import Foundation

class JSONPersistenceService: PersistenceService {
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
    private let url: URL

    func save<Model: Codable>(_ model: Model) {
        // Who has time for error handling?
        let data = try! encoder.encode(model)
        try! data.write(to: url)
    }

    func load<Model: Codable>() -> Model? {
        if let data = try? Data(contentsOf: url) {
            return try? decoder.decode(Model.self, from: data)
        }
        return nil
    }

    // MARK: - Initialization

    required init(url: URL) {
        self.url = url
    }
}
