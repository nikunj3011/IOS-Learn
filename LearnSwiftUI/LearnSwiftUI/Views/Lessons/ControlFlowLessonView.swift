import SwiftUI

struct ControlFlowLessonView: View {
    @StateObject private var viewModel = ControlFlowViewModel()

    var body: some View {
        List {
            Section("if / else") {
                VStack(alignment: .leading, spacing: 12) {
                    HStack { Text("Quiz score"); Spacer(); Text("\(viewModel.score)%").bold() }
                    Slider(value: scoreBinding, in: 0...100, step: 5)
                    Label(viewModel.scoreMessage, systemImage: viewModel.didPass ? "checkmark.circle.fill" : "arrow.up.circle.fill")
                        .foregroundStyle(viewModel.didPass ? .green : .orange)
                }
                CodeBlock(code: """
                if score >= 70 {
                    Text("Great job — you passed!")
                } else {
                    Text("Keep practicing — nearly there.")
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
                ForEach(Array(viewModel.topics.enumerated()), id: \.offset) { index, topic in
                    HStack {
                        Text("\(index + 1)").font(.caption.bold()).foregroundStyle(.white)
                            .frame(width: 26, height: 26).background(.indigo, in: Circle())
                        Text(topic)
                    }
                }
                CodeBlock(code: """
                ForEach(topics, id: \\.self) { topic in
                    Text(topic)
                }
                """)
            }
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
