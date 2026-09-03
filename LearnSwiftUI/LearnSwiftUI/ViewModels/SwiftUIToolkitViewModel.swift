import Combine
import Foundation

final class SwiftUIToolkitViewModel: ObservableObject {
    @Published var selectedTab = UIToolkitTab.layout
    @Published var name = ""
    @Published var level = ExperienceLevel.beginner
    @Published var notificationsEnabled = true
    @Published var isSheetPresented = false
    @Published var isFullScreenPresented = false
    @Published var isAlertPresented = false
    @Published var isDialogPresented = false
    @Published private(set) var lastAction = "No action selected"

    let topics = ["Layout", "Modifiers", "Lists", "Scrolling", "Forms", "Navigation"]
    let cards = [
        ComposedCardItem(title: "Input", subtitle: "Immutable properties", symbol: "arrow.down.circle.fill"),
        ComposedCardItem(title: "Layout", subtitle: "A focused child view", symbol: "rectangle.3.group.fill"),
        ComposedCardItem(title: "Action", subtitle: "Closure back to parent", symbol: "arrow.up.circle.fill")
    ]

    var declarativeTitle: String {
        notificationsEnabled ? "State says notifications are on" : "State says notifications are off"
    }

    var formSummary: String {
        let displayName = name.trimmingCharacters(in: .whitespacesAndNewlines)
        return displayName.isEmpty ? "Complete the form" : "\(displayName) · \(level.rawValue)"
    }

    func select(_ item: ComposedCardItem) { lastAction = "Selected component: \(item.title)" }
    func confirmDialogAction() { lastAction = "Destructive dialog action confirmed" }
}
