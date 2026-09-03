import Foundation

enum LessonLoadingState: Equatable {
    case idle
    case loading(progress: Int)
    case loaded(topic: String)
    case failed(message: String)
}
