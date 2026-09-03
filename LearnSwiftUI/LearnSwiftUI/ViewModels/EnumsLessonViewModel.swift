import Combine
import Foundation

final class EnumsLessonViewModel: ObservableObject {
    @Published private(set) var state = LessonLoadingState.idle

    var title: String {
        switch state {
        case .idle: "Ready to load"
        case .loading(let progress): "Loading \(progress)%"
        case .loaded(let topic): "Loaded: \(topic)"
        case .failed(let message): "Failed: \(message)"
        }
    }

    var symbol: String {
        switch state {
        case .idle: "pause.circle.fill"
        case .loading: "arrow.triangle.2.circlepath.circle.fill"
        case .loaded: "checkmark.circle.fill"
        case .failed: "xmark.octagon.fill"
        }
    }

    var tone: LessonStatusTone {
        switch state {
        case .idle: .neutral
        case .loading: .progress
        case .loaded: .success
        case .failed: .failure
        }
    }

    func setIdle() { state = .idle }
    func setLoading() { state = .loading(progress: 60) }
    func setLoaded() { state = .loaded(topic: "Swift enums") }
    func setFailed() { state = .failed(message: "No connection") }
}
