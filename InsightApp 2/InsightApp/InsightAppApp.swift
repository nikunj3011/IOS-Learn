import SwiftUI

@main
struct InsightApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

struct ContentView: View {
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Text("InsightApp - iOS 16.4")
                    .font(.title)
                    .bold()
                Text("This is a scaffold project targeting iOS 16.4")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            .padding()
            .navigationTitle("Home")
        }
    }
}