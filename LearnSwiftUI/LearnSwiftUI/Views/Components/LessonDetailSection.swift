import SwiftUI

struct LessonDetailSection: View {
    let details: LessonDetails

    var body: some View {
        Section("Detailed explanation") {
            Text(details.overview)

            VStack(alignment: .leading, spacing: 10) {
                Text("Key points").font(.headline)
                ForEach(details.keyPoints, id: \.self) { point in
                    Label(point, systemImage: "checkmark.circle")
                }
            }
            .padding(.vertical, 4)

            VStack(alignment: .leading, spacing: 6) {
                Text("Where you use it").font(.headline)
                Text(details.practicalUse).foregroundStyle(.secondary)
            }
            .padding(.vertical, 4)
        }
    }
}
