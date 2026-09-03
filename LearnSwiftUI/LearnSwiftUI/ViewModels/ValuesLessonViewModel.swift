import Foundation
import Combine

final class ValuesLessonViewModel: ObservableObject {
    let courseName = "Learn SwiftUI"

    @Published var learnerName = "Nikunj"
    @Published var practiceMinutes = 15
    @Published var notificationsOn = true

    var displayedValues: [ValueDisplay] {
        [
            ValueDisplay(name: "courseName", value: courseName, type: "String", keyword: "let"),
            ValueDisplay(name: "learnerName", value: learnerName, type: "String", keyword: "var"),
            ValueDisplay(name: "practiceMinutes", value: String(practiceMinutes), type: "Int", keyword: "var"),
            ValueDisplay(name: "notificationsOn", value: String(notificationsOn), type: "Bool", keyword: "var")
        ]
    }

    var codeExample: String {
        """
        let courseName: String = "Learn SwiftUI"
        var learnerName: String = "\(learnerName)"
        var practiceMinutes: Int = \(practiceMinutes)
        var notificationsOn: Bool = \(notificationsOn)
        """
    }
}
