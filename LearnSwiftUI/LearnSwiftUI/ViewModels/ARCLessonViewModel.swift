import Combine
import Foundation

final class ARCLessonViewModel: ObservableObject {
    @Published private(set) var status = "No objects created."
    private var owner: MemoryOwner?

    func createObjects() {
        let parent = MemoryOwner(name: "Parent")
        let child = MemoryOwner(name: "Child")
        parent.partner = child
        child.partner = parent
        parent.onDeinit = { [weak self] in self?.status = "Parent deinitialized; weak links caused no cycle." }
        owner = parent
        status = "Objects alive. Parent strongly retained; partner links are weak."
    }

    func releaseObjects() {
        owner = nil
        if status.hasPrefix("Objects alive") {
            status = "Strong owner released. ARC can reclaim the objects."
        }
    }
}
