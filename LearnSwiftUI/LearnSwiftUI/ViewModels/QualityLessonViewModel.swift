import Combine
import OSLog

final class LoggingLessonViewModel: ObservableObject {
    @Published private(set) var status = "No sample event recorded yet."
    private let logger = Logger(subsystem: "com.evolveddna.LearnSwiftUI", category: "lesson")

    func recordSampleEvent() {
        let lessonNumber = 76
        logger.notice("Opened logging lesson number \(lessonNumber, privacy: .public)")
        status = "Recorded a notice-level event in the unified log."
    }
}
