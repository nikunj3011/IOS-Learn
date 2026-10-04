import SwiftUI

struct SettingsView: View {
    @AppStorage("appAppearance") private var appearance = AppAppearance.system.rawValue

    var body: some View {
        NavigationStack {
            Form {
                Section {
                    Picker("Color mode", selection: $appearance) {
                        ForEach(AppAppearance.allCases) { option in
                            Label(option.rawValue, systemImage: option.symbol)
                                .tag(option.rawValue)
                        }
                    }
                    .pickerStyle(.inline)
                } header: {
                    Text("Appearance")
                } footer: {
                    Text("System follows your device. Light and Dark override it for this app.")
                }

                Section("About") {
                    LabeledContent("Learning path", value: "58 lessons")
                    LabeledContent("Architecture", value: "MVVM")
                }
            }
            .navigationTitle("Settings")
        }
    }
}
