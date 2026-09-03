import SwiftUI

struct MVVMLessonView: View {
    @StateObject private var viewModel = MVVMDemoViewModel()

    var body: some View {
        List {
            Section("View binds; ViewModel decides") {
                TextField("Topic", text: $viewModel.input)
                Text(viewModel.message).foregroundStyle(.blue)
                CodeBlock(code: """
                struct LessonView: View {
                    @StateObject private var viewModel = LessonViewModel()
                    var body: some View { Text(viewModel.message) }
                }
                """)
            }
            Section("Separation") {
                Label("View: layout and bindings", systemImage: "rectangle")
                Label("ViewModel: presentation state and actions", systemImage: "gearshape")
                Label("Model: domain data and rules", systemImage: "shippingbox")
            }
            LessonDetailSection(details: LessonDetailsCatalog.mvvm)
        }
        .navigationTitle("MVVM")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct FeatureArchitectureLessonView: View {
    var body: some View {
        List {
            Section("Feature-first structure") {
                CodeBlock(code: """
                Features/
                  Courses/
                    CourseListView.swift
                    CourseListViewModel.swift
                    Course.swift
                    CourseRepository.swift
                  Profile/
                    ProfileView.swift
                    ProfileViewModel.swift
                Shared/
                  Components/
                """)
            }
            Section("Why it scales") {
                Label("Related code changes together", systemImage: "folder.fill")
                Label("Feature ownership is clear", systemImage: "person.2.fill")
                Label("Boundaries limit accidental coupling", systemImage: "square.dashed")
            }
            LessonDetailSection(details: LessonDetailsCatalog.featureArchitecture)
        }
        .navigationTitle("Feature Architecture")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct DependencyInjectionLessonView: View {
    @StateObject private var viewModel: DependencyInjectionViewModel

    init(greetingProvider: any GreetingProviding = FriendlyGreetingService()) {
        _viewModel = StateObject(wrappedValue: DependencyInjectionViewModel(greetingProvider: greetingProvider))
    }

    var body: some View {
        List {
            Section("Injected service") {
                TextField("Name", text: $viewModel.name)
                Text(viewModel.greeting).font(.headline).foregroundStyle(.purple)
                CodeBlock(code: """
                init(greetingProvider: GreetingProviding) {
                    self.greetingProvider = greetingProvider
                }

                // Production
                ViewModel(greetingProvider: FriendlyService())
                // Test
                ViewModel(greetingProvider: TestService())
                """)
            }
            LessonDetailSection(details: LessonDetailsCatalog.dependencyInjection)
        }
        .navigationTitle("Dependency Injection")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct RepositoryLessonView: View {
    @StateObject private var viewModel: RepositoryLessonViewModel

    init(repository: any CourseRepository = InMemoryCourseRepository()) {
        _viewModel = StateObject(wrappedValue: RepositoryLessonViewModel(repository: repository))
    }

    var body: some View {
        List {
            Section("Data abstraction") {
                Button("Load courses", action: viewModel.load).buttonStyle(.borderedProminent)
                Text(viewModel.status).foregroundStyle(.secondary)
                ForEach(viewModel.courses) { course in
                    Label(course.title, systemImage: "book.fill")
                }
            }
            Section("Repository contract") {
                CodeBlock(code: """
                protocol CourseRepository {
                    func fetchCourses() async throws -> [Course]
                }

                final class ViewModel {
                    let repository: CourseRepository
                }
                """)
            }
            LessonDetailSection(details: LessonDetailsCatalog.repository)
        }
        .navigationTitle("Repository")
        .navigationBarTitleDisplayMode(.inline)
    }
}
