import SwiftUI

struct ClosuresAdvancedLessonView: View {
    @StateObject private var viewModel = ClosuresAdvancedViewModel()

    var body: some View {
        List {
            Section("Captured values") {
                Text("Captured count: \(viewModel.capturedCount)").font(.headline)
                HStack {
                    Button("Run closure", action: viewModel.runCapturedClosure)
                    Button("Reset", action: viewModel.resetCapture)
                }.buttonStyle(.bordered)
                CodeBlock(code: "var count = 0\nlet increment = { count += 1 }")
            }
            Section("Escaping closure") {
                Text(viewModel.escapingMessage)
                HStack {
                    Button("Save", action: viewModel.saveEscapingClosure)
                    Button("Run later", action: viewModel.runSavedClosure)
                }.buttonStyle(.borderedProminent)
                CodeBlock(code: "func store(_ work: @escaping () -> Void) {\n    savedClosure = work\n}")
            }
            LessonDetailSection(details: LessonDetailsCatalog.closures)
        }
        .navigationTitle("Closures")
        .navigationBarTitleDisplayMode(.inline)
    }
}
