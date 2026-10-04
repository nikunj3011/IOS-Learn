import Combine
import SwiftUI

final class AnimationLessonViewModel: ObservableObject {
    @Published var isExpanded = false

    func toggle() {
        isExpanded.toggle()
    }
}

final class GesturesLessonViewModel: ObservableObject {
    @Published var offset: CGSize = .zero
    @Published var scale = 1.0
    @Published var taps = 0

    func registerTap() { taps += 1 }
    func updateDrag(_ translation: CGSize) { offset = translation }
    func finishDrag() { offset = .zero }
    func updateScale(_ value: CGFloat) { scale = min(max(value, 0.7), 2.0) }
    func resetScale() { scale = 1.0 }
}

final class TestingLessonViewModel: ObservableObject {
    @Published var input = "Swift"
    @Published private(set) var result = ""

    func validate() {
        result = Self.validationMessage(for: input)
    }

    static func validationMessage(for value: String) -> String {
        value.trimmingCharacters(in: .whitespacesAndNewlines).count >= 3
            ? "Valid input"
            : "Enter at least 3 characters"
    }
}
