import SwiftUI

struct ControlFlowLessonView: View {
    @StateObject private var viewModel = ControlFlowViewModel()

    var body: some View {
        List {
            Section("if / else") {
                VStack(alignment: .leading, spacing: 12) {
                    HStack { Text("Quiz score"); Spacer(); Text("\(viewModel.score)%").bold() }
                    Slider(value: scoreBinding, in: 0...100, step: 5)
                    Label(viewModel.scoreMessage, systemImage: viewModel.scoreSymbol)
                        .foregroundStyle(viewModel.didPass ? .green : .orange)
                }
                CodeBlock(code: """
                func scoreMessage(for score: Int) -> String {
                    if score >= 70 {
                        return "Great job — you passed!"
                    } else {
                        return "Keep practicing — nearly there."
                    }
                }
                """)
            }
            Section("switch") {
                Picker("Study day", selection: $viewModel.selectedDay) {
                    ForEach(StudyDay.allCases) { day in Text(day.title).tag(day) }
                }
                Label(viewModel.selectedPlan, systemImage: viewModel.selectedDay.symbol)
                CodeBlock(code: ControlFlowViewModel.switchExample)
            }
            Section("loop with ForEach") {
                ForEach(viewModel.numberedTopics) { topic in
                    HStack {
                        Text("\(topic.number)").font(.caption.bold()).foregroundStyle(.white)
                            .frame(width: 26, height: 26).background(.indigo, in: Circle())
                        Text(topic.title)
                    }
                }
                CodeBlock(code: """
                var numberedTopics: [NumberedTopic] = []
                for (index, topic) in topics.enumerated() {
                    numberedTopics.append(
                        NumberedTopic(number: index + 1, title: topic)
                    )
                }
                """)
            }
            LessonDetailSection(details: LessonDetailsCatalog.controlFlow)
        }
        .navigationTitle("Control Flow")
        .navigationBarTitleDisplayMode(.inline)
    }

    private var scoreBinding: Binding<Double> {
        Binding(
            get: { Double(viewModel.score) },
            set: { viewModel.score = Int($0) }
        )
    }
}
