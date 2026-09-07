import CoreData
import SwiftData
import SwiftUI

struct SwiftDataLessonView: View {
    var body: some View {
        SwiftDataLessonContent()
            .modelContainer(for: PersistentNote.self, inMemory: true)
    }
}

private struct SwiftDataLessonContent: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \PersistentNote.createdAt, order: .reverse) private var notes: [PersistentNote]
    @State private var title = ""

    var body: some View {
        List {
            Section("Live SwiftData context") {
                HStack {
                    TextField("Note title", text: $title)
                    Button("Insert") {
                        let value = title.isEmpty ? "SwiftData note \(notes.count + 1)" : title
                        modelContext.insert(PersistentNote(title: value))
                        title = ""
                    }.buttonStyle(.borderedProminent)
                }
                ForEach(notes) { note in Text(note.title) }
                    .onDelete { indexes in
                        for index in indexes { modelContext.delete(notes[index]) }
                    }
            }
            Section("Model and query") {
                CodeBlock(code: "@Model final class Note { var title: String }\n@Query private var notes: [Note]\nmodelContext.insert(Note(title: title))")
            }
            LessonDetailSection(details: LessonDetailsCatalog.swiftData)
        }
        .navigationTitle("SwiftData")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct CoreDataLessonView: View {
    @StateObject private var viewModel = CoreDataLessonViewModel()

    var body: some View {
        List {
            Section("In-memory managed object context") {
                LabeledContent("Saved objects", value: "\(viewModel.itemCount)")
                Button("Insert and save", action: viewModel.insert).buttonStyle(.borderedProminent)
                Text(viewModel.status).font(.caption).foregroundStyle(.secondary)
            }
            Section("Core Data stack") {
                CodeBlock(code: "let container = NSPersistentContainer(name: \"Model\")\nlet context = container.viewContext\ntry context.save()")
            }
            LessonDetailSection(details: LessonDetailsCatalog.coreData)
        }
        .navigationTitle("Core Data")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct SQLiteLessonView: View {
    @StateObject private var viewModel = SQLiteLessonViewModel()

    var body: some View {
        List {
            Section("Direct SQL") {
                Button("Run INSERT and SELECT", action: viewModel.insert).buttonStyle(.borderedProminent)
                Text(viewModel.status).font(.caption).foregroundStyle(.secondary)
                ForEach(viewModel.titles, id: \.self) { Label($0, systemImage: "tablecells") }
            }
            Section("Prepared statement") {
                CodeBlock(code: "CREATE TABLE lessons (id INTEGER PRIMARY KEY, title TEXT);\nINSERT INTO lessons (title) VALUES (?);\nSELECT title FROM lessons ORDER BY id;")
            }
            LessonDetailSection(details: LessonDetailsCatalog.sqlite)
        }
        .navigationTitle("SQLite")
        .navigationBarTitleDisplayMode(.inline)
    }
}
