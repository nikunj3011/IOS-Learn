import Combine
import Foundation

final class CollectionsLessonViewModel: ObservableObject {
    @Published var newTopic = ""
    @Published private(set) var topics = ["Variables", "Functions", "Optionals"]
    @Published private(set) var completedTopics: Set<String> = ["Variables"]

    let lessonScores = ["Variables": 90, "Functions": 80, "Optionals": 75]

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
