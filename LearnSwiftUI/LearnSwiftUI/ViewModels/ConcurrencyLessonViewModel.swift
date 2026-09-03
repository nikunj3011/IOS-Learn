import Combine
import Foundation

@MainActor
final class ConcurrencyLessonViewModel: ObservableObject {
    @Published private(set) var status = "Ready"
    @Published private(set) var progress = 0
    private var task: Task<Void, Never>?

    func start() {
        task?.cancel()
        task = Task {
            status = "Loading asynchronously…"
            progress = 0
            for step in 1...5 {
                guard !Task.isCancelled else {
                    status = "Cancelled"
                    return
                }
                try? await Task.sleep(for: .milliseconds(250))
                progress = step * 20
            }
            status = "Finished without blocking the UI"
        }
    }

    func cancel() {
        task?.cancel()
        status = "Cancelled"
    }
}
