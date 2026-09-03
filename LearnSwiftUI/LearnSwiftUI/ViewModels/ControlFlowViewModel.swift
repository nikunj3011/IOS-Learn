import Foundation
import Combine

final class ControlFlowViewModel: ObservableObject {
    @Published var score = 65
    @Published var selectedDay = StudyDay.monday

    let topics = ["Variables", "Constants", "Types", "Control flow"]

    var scoreMessage: String { Self.scoreMessage(for: score) }
    var didPass: Bool { score >= 70 }
    var scoreSymbol: String { didPass ? "checkmark.circle.fill" : "arrow.up.circle.fill" }
    var selectedPlan: String { Self.plan(for: selectedDay) }

    var numberedTopics: [NumberedTopic] {
        var result: [NumberedTopic] = []
        for (index, topic) in topics.enumerated() {
            result.append(NumberedTopic(number: index + 1, title: topic))
        }
        return result
    }

    static func scoreMessage(for score: Int) -> String {
        if score >= 70 { "Great job — you passed!" }
        else { "Keep practicing — nearly there." }
    }

    static func plan(for day: StudyDay) -> String {
        switch day {
        case .monday: "Learn a new concept"
        case .wednesday: "Build a tiny project"
        case .friday: "Review and take a quiz"
        }
    }

    static let switchExample = """
    func plan(for day: StudyDay) -> String {
        switch day {
        case .monday: "Learn a new concept"
        case .wednesday: "Build a tiny project"
        case .friday: "Review and take a quiz"
        }
    }
    """
}
