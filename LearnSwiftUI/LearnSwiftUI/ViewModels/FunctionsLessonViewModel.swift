import Combine
import Foundation

final class FunctionsLessonViewModel: ObservableObject {
    @Published var name = "Nikunj"
    @Published var firstNumber = 4
    @Published var secondNumber = 3
    @Published var operation = MathOperation.add

    var greeting: String { Self.greet(name: name) }

    var result: Int {
        let selectedClosure: (Int, Int) -> Int

        switch operation {
        case .add: selectedClosure = { $0 + $1 }
        case .multiply: selectedClosure = { $0 * $1 }
        }

        return Self.calculate(firstNumber, secondNumber, using: selectedClosure)
    }

    static func greet(name: String) -> String {
        "Hello, \(name)!"
    }

    static func calculate(_ first: Int, _ second: Int, using operation: (Int, Int) -> Int) -> Int {
        operation(first, second)
    }
}
