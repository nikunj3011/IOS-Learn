import Combine
import Foundation

@MainActor
final class KeychainLessonViewModel: ObservableObject {
    @Published var token = "demo-secret-token"
    @Published private(set) var status = "No Keychain operation yet"
    private let store: any SecureTokenStore

    init(store: (any SecureTokenStore)? = nil) { self.store = store ?? KeychainTokenStore() }

    func save() { perform { try store.save(token); return "Secret saved securely" } }
    func load() { perform { "Loaded: \(try store.read() ?? "No secret found")" } }
    func delete() { perform { try store.delete(); return "Secret deleted" } }

    private func perform(_ operation: () throws -> String) {
        do { status = try operation() } catch { status = error.localizedDescription }
    }
}

@MainActor
final class FileManagerLessonViewModel: ObservableObject {
    @Published var text = "Hello from FileManager"
    @Published private(set) var status = "No file operation yet"
    private let store: any LessonFileStore

    init(store: (any LessonFileStore)? = nil) { self.store = store ?? FileManagerLessonStore() }

    func write() { perform { "Wrote file: \(try store.write(text).lastPathComponent)" } }
    func read() { perform { "Read: \(try store.read())" } }
    func delete() { perform { try store.delete(); return "File deleted" } }

    private func perform(_ operation: () throws -> String) {
        do { status = try operation() } catch { status = error.localizedDescription }
    }
}
