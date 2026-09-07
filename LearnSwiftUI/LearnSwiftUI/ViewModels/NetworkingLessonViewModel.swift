import Combine
import Foundation

@MainActor
final class NetworkingLessonViewModel: ObservableObject {
    @Published private(set) var todo: NetworkTodo?
    @Published private(set) var restStatus = "Ready to request JSON"
    @Published private(set) var transferStatus = "No transfer started"
    @Published private(set) var socketState = NetworkConnectionState.disconnected
    @Published var socketMessage = "Hello WebSocket"
    @Published private(set) var receivedMessage = "No real-time message received"

    private let client: any NetworkClient
    private var socket: URLSessionWebSocketTask?

    init(client: any NetworkClient = URLSessionNetworkClient()) { self.client = client }

    func fetchRESTResource() {
        Task {
            restStatus = "GET request in progress…"
            do {
                todo = try await client.fetchTodo()
                restStatus = "HTTP GET succeeded and Codable decoded the JSON"
            } catch {
                restStatus = "Request failed: \(error.localizedDescription)"
            }
        }
    }

    func uploadSample() {
        Task {
            do {
                let bytes = try await client.upload(Data("Sample media".utf8))
                transferStatus = "Uploaded \(bytes) bytes"
            } catch { transferStatus = "Upload failed: \(error.localizedDescription)" }
        }
    }

    func downloadSample() {
        Task {
            do {
                let bytes = try await client.download()
                transferStatus = "Downloaded \(bytes) bytes to a temporary file"
            } catch { transferStatus = "Download failed: \(error.localizedDescription)" }
        }
    }

    func connectWebSocket() {
        socketState = .connecting
        let task = client.makeWebSocketTask()
        socket = task
        task.resume()
        socketState = .connected
    }

    func sendWebSocketMessage() {
        guard let socket else { return }
        Task {
            do {
                try await socket.send(.string(socketMessage))
                let response = try await socket.receive()
                if case .string(let text) = response { receivedMessage = text }
            } catch {
                socketState = .failed
                receivedMessage = error.localizedDescription
            }
        }
    }

    func disconnectWebSocket() {
        socket?.cancel(with: .normalClosure, reason: nil)
        socket = nil
        socketState = .disconnected
    }
}
