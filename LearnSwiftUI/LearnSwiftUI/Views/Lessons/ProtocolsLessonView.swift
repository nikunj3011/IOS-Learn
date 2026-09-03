import SwiftUI

struct ProtocolsLessonView: View {
    @StateObject private var viewModel = ProtocolsLessonViewModel()

    var body: some View {
        List {
            Section("One contract, different types") {
                ForEach(viewModel.descriptions, id: \.self) { description in
                    Label(description, systemImage: "checkmark.seal.fill")
                        .foregroundStyle(.teal)
                }
            }
            Section("The protocol") {
                CodeBlock(code: """
                protocol LessonDescribing {
                    var title: String { get }
                    func summary() -> String
                }
                """)
            }
            Section("Conformance") {
                CodeBlock(code: """
                struct SwiftTopic: LessonDescribing {
                    let title: String

                    func summary() -> String {
                        "Learn \\(title) with Swift."
                    }
                }
                """)
            }
            Section("Remember") {
                Text("A protocol defines requirements. Any conforming type promises to provide them, so callers can work with the contract instead of a concrete type.")
            }
        }
        .navigationTitle("Protocols")
        .navigationBarTitleDisplayMode(.inline)
    }
}
