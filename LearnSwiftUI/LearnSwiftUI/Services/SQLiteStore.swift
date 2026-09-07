import Foundation
import SQLite3

enum SQLiteStoreError: Error { case openFailed, statementFailed }

final class SQLiteStore {
    private var database: OpaquePointer?

    init() throws {
        guard sqlite3_open(":memory:", &database) == SQLITE_OK else { throw SQLiteStoreError.openFailed }
        try execute("CREATE TABLE lessons (id INTEGER PRIMARY KEY, title TEXT NOT NULL);")
    }

    deinit { sqlite3_close(database) }

    func insert(title: String) throws {
        var statement: OpaquePointer?
        guard sqlite3_prepare_v2(database, "INSERT INTO lessons (title) VALUES (?);", -1, &statement, nil) == SQLITE_OK else {
            throw SQLiteStoreError.statementFailed
        }
        defer { sqlite3_finalize(statement) }
        sqlite3_bind_text(statement, 1, title, -1, unsafeBitCast(-1, to: sqlite3_destructor_type.self))
        guard sqlite3_step(statement) == SQLITE_DONE else { throw SQLiteStoreError.statementFailed }
    }

    func titles() throws -> [String] {
        var statement: OpaquePointer?
        guard sqlite3_prepare_v2(database, "SELECT title FROM lessons ORDER BY id;", -1, &statement, nil) == SQLITE_OK else {
            throw SQLiteStoreError.statementFailed
        }
        defer { sqlite3_finalize(statement) }
        var result: [String] = []
        while sqlite3_step(statement) == SQLITE_ROW {
            if let text = sqlite3_column_text(statement, 0) { result.append(String(cString: text)) }
        }
        return result
    }

    private func execute(_ sql: String) throws {
        guard sqlite3_exec(database, sql, nil, nil, nil) == SQLITE_OK else { throw SQLiteStoreError.statementFailed }
    }
}
