import Combine
import Foundation

final class DeclarativeUIViewModel: ObservableObject {
    @Published var isLearning = false
    @Published var progress = 2

    var title: String { isLearning ? "Learning in progress" : "Ready to learn" }
    var symbol: String { isLearning ? "book.fill" : "play.circle.fill" }
    var progressText: String { "Completed \(progress) of 5 steps" }
}
