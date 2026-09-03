import SwiftUI

struct ValuesLessonView: View {
    @StateObject private var viewModel = ValuesLessonViewModel()

    var body: some View {
        List {
            Section("Try it") {
                TextField("Your name", text: $viewModel.learnerName)
                Stepper("Practice: \(viewModel.practiceMinutes) minutes", value: $viewModel.practiceMinutes, in: 5...60, step: 5)
                Toggle("Notifications", isOn: $viewModel.notificationsOn)
            }
            Section("The values") {
                ForEach(viewModel.displayedValues) { value in
                    ValueRow(name: value.name, value: value.value, type: value.type, keyword: value.keyword)
                }
            }
            Section("Swift code") {
                CodeBlock(code: viewModel.codeExample)
            }
            Section("Remember") {
                Label("Use let when a value should not change.", systemImage: "lock.fill")
                Label("Use var when a value needs to change.", systemImage: "pencil")
                Label("Swift often infers the type from the value.", systemImage: "sparkles")
            }
        }
        .navigationTitle("Values & Types")
        .navigationBarTitleDisplayMode(.inline)
    }
}
