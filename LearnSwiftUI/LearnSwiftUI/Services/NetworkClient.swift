import Foundation

protocol NetworkClient {
    func fetchTodo() async throws -> NetworkTodo
    func upload(_ data: Data) async throws -> Int
    func download() async throws -> Int
    func makeWebSocketTask() -> URLSessionWebSocketTask
}

struct URLSessionNetworkClient: NetworkClient {
    private let session: URLSession

    init(session: URLSession = .shared) { self.session = session }

    func fetchTodo() async throws -> NetworkTodo {
        let url = URL(string: "https://jsonplaceholder.typicode.com/todos/1")!
        let (data, response) = try await session.data(from: url)
        try validate(response)
        return try JSONDecoder().decode(NetworkTodo.self, from: data)
    }

    func upload(_ data: Data) async throws -> Int {
        let url = URL(string: "https://httpbin.org/post")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/octet-stream", forHTTPHeaderField: "Content-Type")
        let (_, response) = try await session.upload(for: request, from: data)
        try validate(response)
        return data.count
    }

    func download() async throws -> Int {
        let url = URL(string: "https://www.apple.com/favicon.ico")!
        let (temporaryURL, response) = try await session.download(from: url)
        try validate(response)
        let attributes = try FileManager.default.attributesOfItem(atPath: temporaryURL.path)
        return attributes[.size] as? Int ?? 0
    }

    func makeWebSocketTask() -> URLSessionWebSocketTask {
        session.webSocketTask(with: URL(string: "wss://echo.websocket.events")!)
    }

    private func validate(_ response: URLResponse) throws {
        guard let httpResponse = response as? HTTPURLResponse,
              200..<300 ~= httpResponse.statusCode else {
            throw URLError(.badServerResponse)
        }
    }
}
