import Foundation

class ObservationToken: NSObject {}

/// Barebones observable implementation for demonstration purposes.
class Observable<ValueType> {

    private(set) var value: ValueType

    func update(_ newValue: ValueType) {
        let oldValue = value
        value = newValue
        for observation in observations.values {
            observation(oldValue, newValue)
        }
    }

    // MARK: Observation

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

    // MARK: Initialization

    init(initialValue: ValueType) {
        self.value = initialValue
    }
}

// MARK: - Scoped Observation

class ScopedObservationToken {
    fileprivate let inner: ObservationToken
    private let deinitHandler: (ObservationToken) -> Void

    init(inner: ObservationToken, deinitHandler: @escaping (ObservationToken) -> Void) {
        self.inner = inner
        self.deinitHandler = deinitHandler
    }

    deinit {
        deinitHandler(inner)
    }
}

extension Observable {
    func observe(_ observation: @escaping Observation) -> ScopedObservationToken {
        let token: ObservationToken = observe(observation)
        let scopedToken = ScopedObservationToken(
            inner: token,
            deinitHandler: { [weak self] token in
                self?.stopObservation(for: token)
            }
        )
        return scopedToken
    }

    func stopObservation(for token: ScopedObservationToken) {
        stopObservation(for: token.inner)
    }
}
