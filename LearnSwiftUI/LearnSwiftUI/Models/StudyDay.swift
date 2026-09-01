import Foundation

enum StudyDay: String, CaseIterable, Identifiable {
    case monday, wednesday, friday

    var id: Self { self }
    var title: String { rawValue.capitalized }

    var symbol: String {
        switch self {
        case .monday: "book.fill"
        case .wednesday: "hammer.fill"
        case .friday: "checkmark.seal.fill"
        }
    }
}
