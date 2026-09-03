import Foundation

struct ValueDisplay: Identifiable {
    let name: String
    let value: String
    let type: String
    let keyword: String

    var id: String { name }
}

struct NumberedTopic: Identifiable {
    let number: Int
    let title: String

    var id: Int { number }
}

struct TopicCompletion: Identifiable {
    let title: String
    let isCompleted: Bool

    var id: String { title }
    var symbol: String { isCompleted ? "checkmark.circle.fill" : "circle" }
}

struct ScoreDisplay: Identifiable {
    let topic: String
    let score: Int

    var id: String { topic }
}

enum LessonStatusTone {
    case neutral, progress, success, failure
}
