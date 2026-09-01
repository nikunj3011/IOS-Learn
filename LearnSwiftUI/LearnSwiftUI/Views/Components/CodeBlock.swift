import SwiftUI

struct CodeBlock: View {
    let code: String

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            Text(code)
                .font(.caption.monospaced())
                .foregroundStyle(.white)
                .padding()
        }
        .background(Color(red: 0.10, green: 0.12, blue: 0.16), in: RoundedRectangle(cornerRadius: 12))
    }
}
