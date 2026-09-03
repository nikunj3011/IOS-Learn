import SwiftUI

struct LocalStateLessonView: View {
    @State private var count = 0
    @State private var isHighlighted = false

    var body: some View {
        List {
            Section("Local source of truth") {
                Text("Count: \(count)").font(.title2.bold())
                    .foregroundStyle(isHighlighted ? .orange : .primary)
                Stepper("Change count", value: $count)
                Toggle("Highlight", isOn: $isHighlighted)
                CodeBlock(code: "@State private var count = 0\nStepper(\"Count\", value: $count)")
            }
            LessonDetailSection(details: LessonDetailsCatalog.localState)
        }
        .navigationTitle("@State")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct BindingLessonView: View {
    @State private var volume = 5

    var body: some View {
        List {
            Section("Parent owns the value") {
                Text("Parent volume: \(volume)").font(.headline)
                VolumeEditor(volume: $volume)
                CodeBlock(code: "VolumeEditor(volume: $volume)\n\nstruct VolumeEditor: View {\n    @Binding var volume: Int\n}")
            }
            LessonDetailSection(details: LessonDetailsCatalog.binding)
        }
        .navigationTitle("@Binding")
        .navigationBarTitleDisplayMode(.inline)
    }
}

private struct VolumeEditor: View {
    @Binding var volume: Int

    var body: some View {
        VStack(alignment: .leading) {
            Text("Child editor").font(.caption).foregroundStyle(.secondary)
            Slider(value: Binding(get: { Double(volume) }, set: { volume = Int($0) }), in: 0...10, step: 1)
        }
    }
}

struct ObservationLessonView: View {
    @State private var counter = ObservationCounter()

    var body: some View {
        @Bindable var counter = counter
        List {
            Section("@Observable model") {
                Text(counter.summary).font(.headline)
                Stepper("Step: \(counter.step)", value: $counter.step, in: 1...5)
                Button("Increment", action: counter.increment).buttonStyle(.borderedProminent)
                CodeBlock(code: "@Observable final class Counter {\n    var count = 0\n}\n\n@State private var counter = Counter()")
            }
            LessonDetailSection(details: LessonDetailsCatalog.observation)
        }
        .navigationTitle("Observation")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct EnvironmentLessonView: View {
    @State private var preferences = LearningPreferences()

    var body: some View {
        @Bindable var preferences = preferences
        List {
            Section("Provided by an ancestor") {
                TextField("Learner name", text: $preferences.learnerName)
                Toggle("Compact mode", isOn: $preferences.usesCompactMode)
            }
            EnvironmentConsumerView()
            LessonDetailSection(details: LessonDetailsCatalog.environment)
        }
        .environment(preferences)
        .navigationTitle("Environment")
        .navigationBarTitleDisplayMode(.inline)
    }
}

private struct EnvironmentConsumerView: View {
    @Environment(LearningPreferences.self) private var preferences

    var body: some View {
        Section("Read by a descendant") {
            Label("Hello, \(preferences.learnerName)", systemImage: "leaf.fill")
            Text(preferences.usesCompactMode ? "Compact environment value" : "Comfortable environment value")
            CodeBlock(code: "@Environment(LearningPreferences.self) private var preferences")
        }
    }
}
