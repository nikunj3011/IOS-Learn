import Foundation

enum ValidationError: Error, LocalizedError, Equatable {
    case emptyName
    case nameTooShort(minimum: Int)

    var errorDescription: String? {
        switch self {
        case .emptyName: "Name cannot be empty."
        case .nameTooShort(let minimum): "Name must contain at least \(minimum) characters."
        }
    }
}
