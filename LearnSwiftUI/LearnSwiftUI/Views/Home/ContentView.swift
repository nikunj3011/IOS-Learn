import SwiftUI

struct ContentView: View {
    @AppStorage("appAppearance") private var appearance = AppAppearance.system.rawValue

    var body: some View {
        TabView {
            SwiftBasicsHomeView()
                .tabItem { Label("Learn", systemImage: "graduationcap.fill") }
            SettingsView()
                .tabItem { Label("Settings", systemImage: "gearshape.fill") }
        }
        .preferredColorScheme(selectedColorScheme)
    }

    private var selectedColorScheme: ColorScheme? {
        switch AppAppearance(rawValue: appearance) ?? .system {
        case .system: nil
        case .light: .light
        case .dark: .dark
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View { ContentView() }
}
