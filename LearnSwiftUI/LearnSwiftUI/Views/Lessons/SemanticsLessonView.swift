import SwiftUI

struct SemanticsLessonView: View {
    @StateObject private var viewModel = SemanticsLessonViewModel()

    var body: some View {
        List {
            Section("Struct · value semantics") {
                comparison(original: viewModel.structOriginalDescription, copy: viewModel.structCopyDescription)
                Button("Change the struct copy", action: viewModel.runStructExample)
                CodeBlock(code: """
                var original = PlayerValue(name: "Alex")
                var copy = original
                copy.name = "Sam"
                // original is still Alex
                """)
            }
            Section("Class · reference semantics") {
                comparison(original: viewModel.classOriginalDescription, copy: viewModel.classCopyDescription)
                Button("Change the class reference", action: viewModel.runClassExample)
                CodeBlock(code: """
                let original = PlayerReference(name: "Alex")
                let copy = original
                copy.name = "Sam"
                // both now read Sam
                """)
            }
            Section {
                Button("Reset examples", action: viewModel.reset)
            } footer: {
                Text("Structs copy their values. Classes share an identity and are passed by reference.")
            }
        }
        .navigationTitle("Structs & Classes")
        .navigationBarTitleDisplayMode(.inline)
    }

    private func comparison(original: String, copy: String) -> some View {
        HStack {
            Label(original, systemImage: "1.circle.fill")
            Spacer()
            Label(copy, systemImage: "2.circle.fill")
        }
    }
}
