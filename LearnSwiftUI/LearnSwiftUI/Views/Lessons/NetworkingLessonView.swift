import SwiftUI

struct NetworkingLessonView: View {
    @StateObject private var viewModel: NetworkingLessonViewModel

    init(client: any NetworkClient = URLSessionNetworkClient()) {
        _viewModel = StateObject(wrappedValue: NetworkingLessonViewModel(client: client))
    }

    var body: some View {
        List {
            Section("URLSession + REST + Codable") {
                Button("GET and decode a todo", action: viewModel.fetchRESTResource)
                    .buttonStyle(.borderedProminent)
                Text(viewModel.restStatus).font(.caption).foregroundStyle(.secondary)
                if let todo = viewModel.todo {
                    VStack(alignment: .leading, spacing: 6) {
                        Text(todo.title).font(.headline)
                        Label(todo.completed ? "Completed" : "Not completed", systemImage: todo.completed ? "checkmark.circle.fill" : "circle")
                    }
                }
                CodeBlock(code: """
                let (data, response) = try await URLSession.shared.data(from: url)
                guard let http = response as? HTTPURLResponse,
                      200..<300 ~= http.statusCode else { throw APIError.badResponse }
                let todo = try JSONDecoder().decode(NetworkTodo.self, from: data)
                """)
            }

            Section("Codable model") {
                CodeBlock(code: """
                struct NetworkTodo: Codable {
                    let id: Int
                    let title: String
                    let completed: Bool
                }
                """)
            }

            Section("Upload and download") {
                HStack {
                    Button("Upload sample", action: viewModel.uploadSample)
                    Button("Download file", action: viewModel.downloadSample)
                }
                .buttonStyle(.bordered)
                Text(viewModel.transferStatus).font(.caption).foregroundStyle(.secondary)
                CodeBlock(code: """
                try await session.upload(for: request, from: data)
                let (fileURL, response) = try await session.download(from: url)
                """)
            }

            Section("WebSocket · real-time connection") {
                LabeledContent("Connection", value: viewModel.socketState.rawValue)
                TextField("Message", text: $viewModel.socketMessage)
                HStack {
                    Button("Connect", action: viewModel.connectWebSocket)
                    Button("Send", action: viewModel.sendWebSocketMessage)
                    Button("Disconnect", action: viewModel.disconnectWebSocket)
                }
                .buttonStyle(.bordered)
                Text(viewModel.receivedMessage).font(.caption).foregroundStyle(.secondary)
                CodeBlock(code: """
                let socket = session.webSocketTask(with: url)
                socket.resume()
                try await socket.send(.string(message))
                let response = try await socket.receive()
                """)
            }

            Section("Production boundary") {
                CodeBlock(code: """
                protocol NetworkClient {
                    func fetchTodo() async throws -> NetworkTodo
                }

                final class ViewModel {
                    let client: NetworkClient // injected
                }
                """)
            }

            LessonDetailSection(details: LessonDetailsCatalog.networking)
        }
        .navigationTitle("Networking Essentials")
        .navigationBarTitleDisplayMode(.inline)
        .onDisappear(perform: viewModel.disconnectWebSocket)
    }
}
