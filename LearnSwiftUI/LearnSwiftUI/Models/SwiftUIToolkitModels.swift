import Foundation

enum UIToolkitTab: String, CaseIterable, Identifiable {
    case layout = "Layout"
    case data = "Lists"
    case form = "Form"
    case actions = "Actions"

    var id: Self { self }

    var symbol: String {
        switch self {
        case .layout: "rectangle.3.group"
        case .data: "list.bullet"
        case .form: "rectangle.and.pencil.and.ellipsis"
        case .actions: "hand.tap"
        }
    }
}

enum ExperienceLevel: String, CaseIterable, Identifiable {
    case beginner = "Beginner"
    case intermediate = "Intermediate"
    case advanced = "Advanced"

    var id: Self { self }
}
