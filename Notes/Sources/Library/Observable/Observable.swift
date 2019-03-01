import Foundation

class ObservationToken: NSObject {}

/*
 Barebones observable implementation for demonstration purposes.
 */
class Observable<ValueType> {
    private(set) var value: ValueType

    func update(_ newValue: ValueType) {
        let oldValue = value
        value = newValue
        for observation in observations.values {
            observation(oldValue, newValue)
        }
    }

    // MARK: - Observation

    typealias Observation = (_ oldValue: ValueType, _ newValue: ValueType) -> Void

    private var observations: [ObservationToken: Observation] = [:]

    func observe(_ observation: @escaping Observation) -> ObservationToken {
        let token = ObservationToken()
        observations[token] = observation
        return token
    }

    func stopObservation(for token: ObservationToken) {
        observations[token] = nil
    }

    // MARK: - Initialization

    init(initialValue: ValueType) {
        self.value = initialValue
    }
}
