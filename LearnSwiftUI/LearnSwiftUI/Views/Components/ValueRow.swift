import SwiftUI

struct ValueRow: View {
    let name: String
    let value: String
    let type: String
    let keyword: String

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack {
                Text("\(keyword) \(name)").font(.body.monospaced())
                Spacer()
                Text(type)
                    .font(.caption.bold())
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(.blue.opacity(0.12), in: Capsule())
            }
            Text(value).foregroundStyle(.secondary)
        }
        .padding(.vertical, 3)
    }
}
