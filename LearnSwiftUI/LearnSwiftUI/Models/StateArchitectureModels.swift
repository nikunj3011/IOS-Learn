import Foundation
import Observation

@Observable
final class ObservationCounter {
    var count = 0
    var step = 1

    var summary: String { "Count \(count), changing by \(step)" }
    func increment() { count += step }
}

@Observable
final class LearningPreferences {
    var learnerName = "Nikunj"
    var usesCompactMode = false
}

protocol GreetingProviding {
    func greeting(for name: String) -> String
}

struct FriendlyGreetingService: GreetingProviding {
    func greeting(for name: String) -> String { "Welcome, \(name)!" }
}

struct TestGreetingService: GreetingProviding {
    func greeting(for name: String) -> String { "Test greeting for \(name)" }
}

struct Course: Identifiable, Equatable {
    let id: Int
    let title: String
}

protocol CourseRepository {
    func fetchCourses() async throws -> [Course]
}

struct InMemoryCourseRepository: CourseRepository {
    func fetchCourses() async throws -> [Course] {
        [Course(id: 1, title: "Swift"), Course(id: 2, title: "SwiftUI")]
    }
}
