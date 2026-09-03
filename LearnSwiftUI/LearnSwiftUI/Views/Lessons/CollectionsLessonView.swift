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
                ForEach(viewModel.numberedTopics) { topic in
                    Text("\(topic.number). \(topic.title)")
                }
                CodeBlock(code: "var topics = [\"Variables\", \"Functions\"]")
            }

            Section("Set · unique values") {
                ForEach(viewModel.topicCompletions) { topic in
                    Button {
                        viewModel.toggleCompleted(topic.title)
                    } label: {
                        Label(topic.title, systemImage: topic.symbol)
                    }
                    .buttonStyle(.plain)
                }
                Text(viewModel.completedSummary)
                    .font(.caption)
                    .foregroundStyle(.secondary)
                CodeBlock(code: "var completed: Set<String> = [\"Variables\"]")
            }

            Section("Dictionary · key and value pairs") {
                ForEach(viewModel.sortedScores) { item in
                    HStack {
                        Text(item.topic)
                        Spacer()
                        Text("\(item.score)%").bold()
                    }
                }
                CodeBlock(code: "let scores = [\"Variables\": 90, \"Functions\": 80]")
            }
            LessonDetailSection(details: LessonDetailsCatalog.collections)
        }
        .navigationTitle("Collections")
        .navigationBarTitleDisplayMode(.inline)
    }
}
