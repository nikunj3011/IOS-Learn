import Foundation
import Combine

final class ValuesLessonViewModel: ObservableObject {
    let courseName = "Learn SwiftUI"

    @Published var learnerName = "Nikunj"
    @Published var practiceMinutes = 15
    @Published var notificationsOn = true

    var codeExample: String {
        """
        let courseName: String = "Learn SwiftUI"
        var learnerName: String = "\(learnerName)"
        var practiceMinutes: Int = \(practiceMinutes)
        var notificationsOn: Bool = \(notificationsOn)
        """
    }
}
