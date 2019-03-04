/// When this token gets deallocated, observation stops.
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
