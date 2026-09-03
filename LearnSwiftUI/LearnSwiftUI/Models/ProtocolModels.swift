import Foundation

protocol LessonDescribing {
    var title: String { get }
    func summary() -> String
}

struct SwiftTopic: LessonDescribing {
    let title: String

    func summary() -> String {
        "Learn \(title) with Swift."
    }
}

struct PracticeProject: LessonDescribing {
    let title: String

    func summary() -> String {
        "Build \(title) in SwiftUI."
    }
}
