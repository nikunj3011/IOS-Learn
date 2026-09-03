import Combine
import Foundation

final class OptionalsLessonViewModel: ObservableObject {
    @Published var nicknameInput = ""

    var nickname: String? {
        let trimmedName = nicknameInput.trimmingCharacters(in: .whitespacesAndNewlines)
        return trimmedName.isEmpty ? nil : trimmedName
    }

    var ifLetMessage: String {
        if let nickname {
            return "Welcome, \(nickname)!"
        } else {
            return "No nickname was provided."
        }
    }

    var hasNickname: Bool { nickname != nil }
    var statusSymbol: String { hasNickname ? "checkmark.circle.fill" : "questionmark.circle" }
    var guardMessage: String { Self.guardLetMessage(for: nickname) }

    static func guardLetMessage(for name: String?) -> String {
        guard let name, !name.isEmpty else {
            return "Please enter a nickname first."
        }
        return "Profile saved for \(name)."
    }
}
