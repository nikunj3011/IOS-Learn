import SwiftUI

struct DeclarativeUILessonView: View {
    @StateObject private var viewModel = DeclarativeUIViewModel()

    var body: some View {
        List {
            Section("State drives the view") {
                Toggle("Currently learning", isOn: $viewModel.isLearning)
                Stepper(viewModel.progressText, value: $viewModel.progress, in: 0...5)
                Label(viewModel.title, systemImage: viewModel.symbol)
                    .font(.headline).foregroundStyle(.blue)
            }
            Section("Declare the result") {
                CodeBlock(code: """
                var body: some View {
                    VStack {
                        Text(title)
                        ProgressView(value: progress)
                    }
                }
                """)
            }
            LessonDetailSection(details: LessonDetailsCatalog.swiftUI)
        }
        .navigationTitle("Declarative SwiftUI")
        .navigationBarTitleDisplayMode(.inline)
    }
}
