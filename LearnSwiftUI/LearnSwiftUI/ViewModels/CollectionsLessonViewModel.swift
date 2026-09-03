import Combine
import Foundation

final class CollectionsLessonViewModel: ObservableObject {
    @Published var newTopic = ""
    @Published private(set) var topics = ["Variables", "Functions", "Optionals"]
    @Published private(set) var completedTopics: Set<String> = ["Variables"]

    let lessonScores = ["Variables": 90, "Functions": 80, "Optionals": 75]

    var numberedTopics: [NumberedTopic] {
        var result: [NumberedTopic] = []
        for (index, topic) in topics.enumerated() {
            result.append(NumberedTopic(number: index + 1, title: topic))
        }
        return result
    }

    var topicCompletions: [TopicCompletion] {
        topics.map { topic in
            TopicCompletion(title: topic, isCompleted: completedTopics.contains(topic))
        }
    }

    var sortedScores: [ScoreDisplay] {
        lessonScores
            .map { ScoreDisplay(topic: $0.key, score: $0.value) }
            .sorted { $0.topic < $1.topic }
    }

    var completedSummary: String {
        "\(completedTopics.count) unique completed topic(s)"
    }

    func addTopic() {
        let trimmedTopic = newTopic.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmedTopic.isEmpty else { return }
        topics.append(trimmedTopic)
        newTopic = ""
    }

    func toggleCompleted(_ topic: String) {
        if completedTopics.contains(topic) {
            completedTopics.remove(topic)
        } else {
            completedTopics.insert(topic)
        }
    }
}
