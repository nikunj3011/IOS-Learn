import Combine
import Foundation

final class ClosuresAdvancedViewModel: ObservableObject {
    @Published private(set) var capturedCount = 0
    @Published private(set) var escapingMessage = "No saved closure has run."
    private var increment: (() -> Int)?
    private var savedClosure: (() -> Void)?

    init() { resetCapture() }

    func runCapturedClosure() { capturedCount = increment?() ?? 0 }

    func resetCapture() {
        var count = 0
        increment = {
            count += 1
            return count
        }
        capturedCount = 0
    }

    func saveEscapingClosure() {
        escapingMessage = "Closure saved for later."
        storeForLater { [weak self] in
            self?.escapingMessage = "The escaping closure ran later."
        }
    }

    func runSavedClosure() {
        savedClosure?()
        savedClosure = nil
    }

    private func storeForLater(_ completion: @escaping () -> Void) {
        savedClosure = completion
    }
}
