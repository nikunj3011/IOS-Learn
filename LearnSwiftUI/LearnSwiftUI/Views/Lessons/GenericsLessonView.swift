import SwiftUI

struct GenericsLessonView: View {
    @StateObject private var viewModel = GenericsLessonViewModel()

    var body: some View {
        List {
            Section("The same function, different types") {
                Stepper("Numbers: \(viewModel.firstNumber), \(viewModel.secondNumber)", value: $viewModel.firstNumber, in: 0...50)
                Text(viewModel.numbersDescription)
                    .foregroundStyle(.blue)
                TextField("First word", text: $viewModel.firstWord)
                TextField("Second word", text: $viewModel.secondWord)
                Text(viewModel.wordsDescription)
                    .foregroundStyle(.purple)
            }
            Section("Generic code") {
                CodeBlock(code: """
                func swapped<T>(_ first: T, _ second: T) -> (T, T) {
                    (second, first)
                }

                swapped(10, 20)       // Int
                swapped("Swift", "UI") // String
                """)
            }
            Section("Remember") {
                Text("T is a placeholder for a type. Swift selects the real type at the call site while preserving type safety.")
            }
            LessonDetailSection(details: LessonDetailsCatalog.generics)
        }
        .navigationTitle("Generics")
        .navigationBarTitleDisplayMode(.inline)
    }
}
