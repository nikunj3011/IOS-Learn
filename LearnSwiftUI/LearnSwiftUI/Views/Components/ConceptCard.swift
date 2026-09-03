import SwiftUI

struct ConceptCard: View {
    let item: ComposedCardItem
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: 12) {
                Image(systemName: item.symbol).font(.title2).foregroundStyle(.blue)
                VStack(alignment: .leading) {
                    Text(item.title).font(.headline)
                    Text(item.subtitle).font(.caption).foregroundStyle(.secondary)
                }
                Spacer()
            }
            .padding(.vertical, 4)
        }
        .buttonStyle(.plain)
    }
}
