import Combine
import Foundation

final class ViewCompositionLessonViewModel: ObservableObject {
    let cards = [
        ComposedCardItem(title: "Input", subtitle: "Immutable properties", symbol: "arrow.down.circle.fill"),
        ComposedCardItem(title: "Layout", subtitle: "A focused child view", symbol: "rectangle.3.group.fill"),
        ComposedCardItem(title: "Action", subtitle: "Closure back to parent", symbol: "arrow.up.circle.fill")
    ]
    @Published private(set) var selectedTitle = "Select a component"

    func select(_ item: ComposedCardItem) { selectedTitle = "Selected: \(item.title)" }
}
