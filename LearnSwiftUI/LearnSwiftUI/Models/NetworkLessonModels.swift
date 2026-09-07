import Foundation

struct NetworkTodo: Codable, Identifiable, Equatable {
    let userId: Int
    let id: Int
    let title: String
    let completed: Bool
}

enum NetworkConnectionState: String {
    case disconnected = "Disconnected"
    case connecting = "Connecting"
    case connected = "Connected"
    case failed = "Failed"
}
