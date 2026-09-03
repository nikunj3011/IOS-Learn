import SwiftUI

struct EnumsLessonView: View {
    @StateObject private var viewModel = EnumsLessonViewModel()

    var body: some View {
        List {
            Section("Model one valid state") {
                Label(viewModel.title, systemImage: viewModel.symbol)
                    .font(.headline)
                    .foregroundStyle(stateColor)
                HStack {
                    Button("Idle", action: viewModel.setIdle)
                    Button("Loading", action: viewModel.setLoading)
                    Button("Loaded", action: viewModel.setLoaded)
                    Button("Failed", action: viewModel.setFailed)
                }
                .buttonStyle(.bordered)
            }
            Section("Associated values") {
                CodeBlock(code: """
                enum LoadingState {
                    case idle
                    case loading(progress: Int)
                    case loaded(topic: String)
                    case failed(message: String)
                }
                """)
            }
            Section("Read state with switch") {
                CodeBlock(code: """
                switch state {
                case .loading(let progress):
                    Text("Loading \\(progress)%")
                case .loaded(let topic):
                    Text("Loaded: \\(topic)")
                // handle remaining cases...
                }
                """)
            }
            LessonDetailSection(details: LessonDetailsCatalog.enums)
        }
        .navigationTitle("Enums")
        .navigationBarTitleDisplayMode(.inline)
    }

    private var stateColor: Color {
        switch viewModel.tone {
        case .neutral: .secondary
        case .progress: .orange
        case .success: .green
        case .failure: .red
        }
    }
}
