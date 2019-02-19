import Foundation

class TimerController {
    private var timer: Timer?
    private var action: (() -> Void)?

    private let interval: TimeInterval
    private let repeats: Bool

    func schedule(action: @escaping () -> Void) {
        invalidate()
        self.action = action
        timer = Timer.scheduledTimer(withTimeInterval: interval, repeats: repeats) { [weak self] _ in
            self?.action?()
        }
    }

    func invalidate() {
        timer?.invalidate()
        timer = nil
        action = nil
    }

    init(interval: TimeInterval, repeats: Bool) {
        self.interval = interval
        self.repeats = repeats
    }
}
