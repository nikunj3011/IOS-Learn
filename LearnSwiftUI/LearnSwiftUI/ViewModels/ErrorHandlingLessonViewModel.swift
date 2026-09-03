import Combine
import Foundation

final class ErrorHandlingLessonViewModel: ObservableObject {
    @Published var name = ""
    @Published private(set) var resultMessage = "Enter a name and validate it."
    @Published private(set) var isSuccess = false

    var resultSymbol: String {
        isSuccess ? "checkmark.circle.fill" : "exclamationmark.circle.fill"
    }

    func validateWithTry() {
        do {
            let validName = try Self.validate(name)
            resultMessage = "try succeeded: \(validName)"
            isSuccess = true
        } catch {
            resultMessage = error.localizedDescription
            isSuccess = false
        }
    }

    func validateWithResult() {
        let result = Result { try Self.validate(name) }
        switch result {
        case .success(let validName):
            resultMessage = "Result.success: \(validName)"
            isSuccess = true
        case .failure(let error):
            resultMessage = "Result.failure: \(error.localizedDescription)"
            isSuccess = false
        }
    }

    static func validate(_ name: String) throws -> String {
        let trimmedName = name.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmedName.isEmpty else { throw ValidationError.emptyName }
        guard trimmedName.count >= 3 else { throw ValidationError.nameTooShort(minimum: 3) }
        return trimmedName
    }
}
