import SwiftUI

struct UserDefaultsLessonView: View {
    @AppStorage("lessonDisplayName") private var displayName = "Learner"
    @AppStorage("lessonHaptics") private var hapticsEnabled = true

    var body: some View {
        List {
            Section("Persistent preferences") {
                TextField("Display name", text: $displayName)
                Toggle("Haptics", isOn: $hapticsEnabled)
                Text("Close and reopen this screen—the values remain.").font(.caption).foregroundStyle(.secondary)
            }
            Section("@AppStorage") {
                CodeBlock(code: "@AppStorage(\"displayName\") private var name = \"Learner\"\n@AppStorage(\"haptics\") private var haptics = true")
            }
            LessonDetailSection(details: LessonDetailsCatalog.userDefaults)
        }
        .navigationTitle("UserDefaults")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct KeychainLessonView: View {
    @StateObject private var viewModel = KeychainLessonViewModel()

    var body: some View {
        List {
            Section("Secure secret") {
                SecureField("Token", text: $viewModel.token)
                HStack {
                    Button("Save", action: viewModel.save)
                    Button("Load", action: viewModel.load)
                    Button("Delete", role: .destructive, action: viewModel.delete)
                }.buttonStyle(.bordered)
                Text(viewModel.status).font(.caption).foregroundStyle(.secondary)
            }
            Section("Security framework") {
                CodeBlock(code: "SecItemAdd(query as CFDictionary, nil)\nSecItemCopyMatching(query as CFDictionary, &item)\nSecItemDelete(query as CFDictionary)")
            }
            LessonDetailSection(details: LessonDetailsCatalog.keychain)
        }
        .navigationTitle("Keychain")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct FileManagerLessonView: View {
    @StateObject private var viewModel = FileManagerLessonViewModel()

    var body: some View {
        List {
            Section("Sandboxed file") {
                TextField("File contents", text: $viewModel.text)
                HStack {
                    Button("Write", action: viewModel.write)
                    Button("Read", action: viewModel.read)
                    Button("Delete", role: .destructive, action: viewModel.delete)
                }.buttonStyle(.bordered)
                Text(viewModel.status).font(.caption).foregroundStyle(.secondary)
            }
            Section("Atomic file write") {
                CodeBlock(code: "let url = FileManager.default.temporaryDirectory\n    .appending(path: \"note.txt\")\ntry data.write(to: url, options: .atomic)")
            }
            LessonDetailSection(details: LessonDetailsCatalog.fileManager)
        }
        .navigationTitle("FileManager")
        .navigationBarTitleDisplayMode(.inline)
    }
}
