import SwiftUI

struct OptionalsLessonView: View {
    @StateObject private var viewModel = OptionalsLessonViewModel()

    var body: some View {
        List {
            Section("Try an optional") {
                TextField("Nickname (optional)", text: $viewModel.nicknameInput)
                Label(viewModel.ifLetMessage, systemImage: viewModel.nickname == nil ? "questionmark.circle" : "checkmark.circle.fill")
                    .foregroundStyle(viewModel.nickname == nil ? .orange : .green)
            }

            Section("? means the value may be nil") {
                CodeBlock(code: "var nickname: String? = nil")
            }

            Section("Safely unwrap with if let") {
                CodeBlock(code: """
                if let nickname = nickname {
                    Text("Welcome, \\(nickname)!")
                } else {
                    Text("No nickname was provided.")
                }
                """)
            }

            Section("Exit early with guard let") {
                Text(OptionalsLessonViewModel.guardLetMessage(for: viewModel.nickname))
                    .foregroundStyle(.secondary)
                CodeBlock(code: """
                guard let nickname else {
                    return
                }
                saveProfile(for: nickname)
                """)
            }

            Section("About !") {
                Label("Forced unwrapping can crash when the value is nil. Prefer if let or guard let.", systemImage: "exclamationmark.triangle.fill")
                    .foregroundStyle(.red)
            }
        }
        .navigationTitle("Optionals")
        .navigationBarTitleDisplayMode(.inline)
    }
}
