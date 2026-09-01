import SwiftUI

struct FunctionsLessonView: View {
    @StateObject private var viewModel = FunctionsLessonViewModel()

    var body: some View {
        List {
            Section("Parameters and return values") {
                TextField("Your name", text: $viewModel.name)
                Label(viewModel.greeting, systemImage: "function")
                    .foregroundStyle(.blue)
                CodeBlock(code: """
                func greet(name: String) -> String {
                    return "Hello, \\(name)!"
                }

                let message = greet(name: "\(viewModel.name)")
                """)
            }

            Section("Closures") {
                Stepper("First number: \(viewModel.firstNumber)", value: $viewModel.firstNumber, in: 0...20)
                Stepper("Second number: \(viewModel.secondNumber)", value: $viewModel.secondNumber, in: 0...20)
                Picker("Operation", selection: $viewModel.operation) {
                    ForEach(MathOperation.allCases) { operation in
                        Label(operation.rawValue, systemImage: operation.symbol).tag(operation)
                    }
                }
                Label("Result: \(viewModel.result)", systemImage: "equal.circle.fill")
                    .font(.headline)
                    .foregroundStyle(.purple)
                CodeBlock(code: """
                let add: (Int, Int) -> Int = { a, b in
                    a + b
                }

                let result = calculate(4, 3, using: add)
                """)
            }

            Section("Remember") {
                Label("Parameters are inputs to a function.", systemImage: "arrow.right.to.line")
                Label("The return value is the function's output.", systemImage: "arrow.left.to.line")
                Label("A closure is a function stored as a value.", systemImage: "curlybraces")
            }
        }
        .navigationTitle("Functions")
        .navigationBarTitleDisplayMode(.inline)
    }
}
