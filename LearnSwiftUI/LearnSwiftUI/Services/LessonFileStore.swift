import Foundation

protocol LessonFileStore {
    func write(_ text: String) throws -> URL
    func read() throws -> String
    func delete() throws
}

struct FileManagerLessonStore: LessonFileStore {
    private let fileManager = FileManager.default

    private var fileURL: URL {
        fileManager.temporaryDirectory.appending(path: "learn-swiftui-note.txt")
    }

    func write(_ text: String) throws -> URL {
        try Data(text.utf8).write(to: fileURL, options: .atomic)
        return fileURL
    }

    func read() throws -> String {
        let data = try Data(contentsOf: fileURL)
        return String(decoding: data, as: UTF8.self)
    }

    func delete() throws {
        guard fileManager.fileExists(atPath: fileURL.path) else { return }
        try fileManager.removeItem(at: fileURL)
    }
}
