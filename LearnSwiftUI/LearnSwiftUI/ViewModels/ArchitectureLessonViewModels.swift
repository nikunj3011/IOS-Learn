import Combine
import Foundation

final class MVVMDemoViewModel: ObservableObject {
    @Published var input = "Swift"
    var message: String { input.isEmpty ? "Enter a topic" : "ViewModel prepared: \(input)" }
}

final class DependencyInjectionViewModel: ObservableObject {
    @Published var name = "Nikunj"
    private let greetingProvider: any GreetingProviding

    init(greetingProvider: any GreetingProviding) {
        self.greetingProvider = greetingProvider
    }

    var greeting: String { greetingProvider.greeting(for: name) }
}

@MainActor
final class RepositoryLessonViewModel: ObservableObject {
    @Published private(set) var courses: [Course] = []
    @Published private(set) var status = "Repository has not loaded data."
    private let repository: any CourseRepository

    init(repository: any CourseRepository) { self.repository = repository }

    func load() {
        Task {
            do {
                courses = try await repository.fetchCourses()
                status = "Loaded through CourseRepository"
            } catch {
                status = error.localizedDescription
            }
        }
    }
}
