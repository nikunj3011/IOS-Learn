import Foundation
import Combine

final class ProtocolsLessonViewModel: ObservableObject {
    let items: [any LessonDescribing] = [
        SwiftTopic(title: "Protocols"),
        PracticeProject(title: "a reusable lesson card")
    ]

    var descriptions: [String] {
        var result: [String] = []
        for item in items {
            result.append(Self.describe(item))
        }
        return result
    }

    static func describe(_ item: any LessonDescribing) -> String {
        item.summary()
    }
}
