import SwiftUI

struct ErrorHandlingLessonView: View {
    @StateObject private var viewModel = ErrorHandlingLessonViewModel()

    var body: some View {
        List {
            Section("Try it") {
                TextField("Name (3+ characters)", text: $viewModel.name)
                HStack {
                    Button("Use try", action: viewModel.validateWithTry)
                    Button("Use Result", action: viewModel.validateWithResult)
                }
                .buttonStyle(.borderedProminent)
                Label(viewModel.resultMessage, systemImage: viewModel.resultSymbol)
                    .foregroundStyle(viewModel.isSuccess ? .green : .orange)
            }
            Section("throws, try, and catch") {
                CodeBlock(code: """
                func validate(_ name: String) throws -> String {
                    guard !name.isEmpty else {
                        throw ValidationError.emptyName
                    }
                    return name
                }

                do { let name = try validate(input) }
                catch { print(error) }
                """)
            }
            Section("Result") {
                CodeBlock(code: """
                let result: Result<String, Error> = Result {
                    try validate(input)
                }
                """)
                Text("Result stores either .success(Value) or .failure(Error), which is useful when the outcome must be passed or saved.")
            }
            LessonDetailSection(details: LessonDetailsCatalog.errors)
        }
        .navigationTitle("Error Handling")
        .navigationBarTitleDisplayMode(.inline)
    }
}
