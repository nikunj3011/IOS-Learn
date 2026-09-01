import Foundation

enum MathOperation: String, CaseIterable, Identifiable {
    case add = "Add"
    case multiply = "Multiply"

    var id: Self { self }

    var symbol: String {
        switch self {
        case .add: "plus"
        case .multiply: "multiply"
        }
    }
}
