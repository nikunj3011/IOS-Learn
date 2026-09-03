import SwiftUI

struct ARCLessonView: View {
    @StateObject private var viewModel = ARCLessonViewModel()

    var body: some View {
        List {
            Section("Object lifetime") {
                Text(viewModel.status)
                HStack {
                    Button("Create", action: viewModel.createObjects)
                    Button("Release", action: viewModel.releaseObjects)
                }.buttonStyle(.borderedProminent)
            }
            Section("Break a retain cycle") {
                CodeBlock(code: """
                final class Person {
                    weak var partner: Person?
                }

                // weak does not increase the strong reference count
                """)
            }
            LessonDetailSection(details: LessonDetailsCatalog.arc)
        }
        .navigationTitle("ARC")
        .navigationBarTitleDisplayMode(.inline)
    }
}
