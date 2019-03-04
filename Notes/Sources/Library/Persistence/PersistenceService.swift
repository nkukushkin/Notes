import Foundation

protocol PersistenceService {
    func save<Model: Codable>(_ model: Model)
    func load<Model: Codable>() -> Model?

    init(url: URL)
}
