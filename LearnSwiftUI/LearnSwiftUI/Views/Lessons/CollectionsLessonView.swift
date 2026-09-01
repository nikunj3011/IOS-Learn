import SwiftUI

struct CollectionsLessonView: View {
    @StateObject private var viewModel = CollectionsLessonViewModel()

    var body: some View {
        List {
            Section("Array · ordered values") {
                HStack {
                    TextField("Add a topic", text: $viewModel.newTopic)
                    Button("Add", action: viewModel.addTopic)
                        .buttonStyle(.borderedProminent)
                }
                ForEach(Array(viewModel.topics.enumerated()), id: \.offset) { index, topic in
                    Text("\(index + 1). \(topic)")
                }
                CodeBlock(code: "var topics = [\"Variables\", \"Functions\"]")
            }

            Section("Set · unique values") {
                ForEach(viewModel.topics, id: \.self) { topic in
                    Button {
                        viewModel.toggleCompleted(topic)
                    } label: {
                        Label(topic, systemImage: viewModel.completedTopics.contains(topic) ? "checkmark.circle.fill" : "circle")
                    }
                    .buttonStyle(.plain)
                }
                Text("\(viewModel.completedTopics.count) unique completed topic(s)")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                CodeBlock(code: "var completed: Set<String> = [\"Variables\"]")
            }

            Section("Dictionary · key and value pairs") {
                ForEach(viewModel.lessonScores.keys.sorted(), id: \.self) { topic in
                    HStack {
                        Text(topic)
                        Spacer()
                        Text("\(viewModel.lessonScores[topic, default: 0])%").bold()
                    }
                }
                CodeBlock(code: "let scores = [\"Variables\": 90, \"Functions\": 80]")
            }
        }
        .navigationTitle("Collections")
        .navigationBarTitleDisplayMode(.inline)
    }
}
