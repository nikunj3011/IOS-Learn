import SwiftUI

struct ViewCompositionLessonView: View {
    @StateObject private var viewModel = ViewCompositionLessonViewModel()

    var body: some View {
        List {
            Section("Reusable child views") {
                Text(viewModel.selectedTitle).font(.headline)
                ForEach(viewModel.cards) { item in
                    ConceptCard(item: item) { viewModel.select(item) }
                }
            }
            Section("Compose a screen") {
                CodeBlock(code: """
                struct ConceptCard: View {
                    let item: CardItem
                    let action: () -> Void

                    var body: some View { Button(action: action) { ... } }
                }
                """)
            }
            LessonDetailSection(details: LessonDetailsCatalog.composition)
        }
        .navigationTitle("View Composition")
        .navigationBarTitleDisplayMode(.inline)
    }
}
