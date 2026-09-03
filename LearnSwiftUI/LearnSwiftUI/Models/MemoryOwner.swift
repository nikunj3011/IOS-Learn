import Foundation

final class MemoryOwner {
    let name: String
    weak var partner: MemoryOwner?
    var onDeinit: (() -> Void)?

    init(name: String) { self.name = name }
    deinit { onDeinit?() }
}
