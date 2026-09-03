import SwiftUI

struct ConcurrencyLessonView: View {
    @StateObject private var viewModel = ConcurrencyLessonViewModel()

    var body: some View {
        List {
            Section("Run asynchronous work") {
                Text(viewModel.status)
                ProgressView(value: Double(viewModel.progress), total: 100)
                HStack {
                    Button("Start Task", action: viewModel.start)
                    Button("Cancel", action: viewModel.cancel)
                }.buttonStyle(.borderedProminent)
            }
            Section("async / await") {
                CodeBlock(code: """
                func loadLesson() async throws -> Lesson {
                    try await api.fetchLesson()
                }

                Task {
                    let lesson = try await loadLesson()
                }
                """)
            }
            LessonDetailSection(details: LessonDetailsCatalog.concurrency)
        }
        .navigationTitle("Concurrency")
        .navigationBarTitleDisplayMode(.inline)
    }
}
