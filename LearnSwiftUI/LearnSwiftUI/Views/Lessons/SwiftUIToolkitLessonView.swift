import SwiftUI

struct SwiftUIToolkitLessonView: View {
    @StateObject private var viewModel = SwiftUIToolkitViewModel()

    var body: some View {
        TabView(selection: $viewModel.selectedTab) {
            layoutTab
                .tabItem { Label("Layout", systemImage: "rectangle.3.group") }
                .tag(UIToolkitTab.layout)

            dataTab
                .tabItem { Label("Lists", systemImage: "list.bullet") }
                .tag(UIToolkitTab.data)

            formTab
                .tabItem { Label("Form", systemImage: "rectangle.and.pencil.and.ellipsis") }
                .tag(UIToolkitTab.form)

            actionsTab
                .tabItem { Label("Actions", systemImage: "hand.tap") }
                .tag(UIToolkitTab.actions)
        }
        .navigationTitle("SwiftUI Toolkit")
        .navigationBarTitleDisplayMode(.inline)
        .sheet(isPresented: $viewModel.isSheetPresented) {
            PresentationExample(title: "Sheet", symbol: "rectangle.bottomhalf.inset.filled")
        }
        .fullScreenCover(isPresented: $viewModel.isFullScreenPresented) {
            PresentationExample(title: "Full-screen cover", symbol: "rectangle.inset.filled")
        }
        .alert("SwiftUI Alert", isPresented: $viewModel.isAlertPresented) {
            Button("OK") { }
        } message: {
            Text("Alerts communicate important information or request a simple decision.")
        }
        .confirmationDialog("Choose an action", isPresented: $viewModel.isDialogPresented, titleVisibility: .visible) {
            Button("Confirm destructive action", role: .destructive, action: viewModel.confirmDialogAction)
            Button("Cancel", role: .cancel) { }
        }
    }

    private var layoutTab: some View {
        ScrollView {
            LazyVStack(alignment: .leading, spacing: 20) {
                GroupBox("HStack · horizontal") {
                    HStack { badge("One", .blue); badge("Two", .purple); badge("Three", .orange) }
                }
                GroupBox("VStack · vertical") {
                    VStack(alignment: .leading) { Text("Top"); Divider(); Text("Bottom") }
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                GroupBox("ZStack · layered") {
                    ZStack {
                        RoundedRectangle(cornerRadius: 16).fill(.blue.gradient).frame(height: 90)
                        Text("Foreground over background").bold().foregroundStyle(.white)
                    }
                }
                GroupBox("Grid · rows and columns") {
                    Grid(horizontalSpacing: 20, verticalSpacing: 10) {
                        GridRow { Text("Topic").bold(); Text("Priority").bold() }
                        GridRow { Text("Layout"); Text("Critical") }
                        GridRow { Text("Modifiers"); Text("Critical") }
                    }
                }
                GroupBox("Modifiers · styling and behavior") {
                    Text(viewModel.declarativeTitle)
                        .font(.headline)
                        .foregroundStyle(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(.indigo.gradient, in: RoundedRectangle(cornerRadius: 14))
                    Toggle("Change state", isOn: $viewModel.notificationsEnabled)
                }
                GroupBox("View composition") {
                    Text(viewModel.lastAction).font(.subheadline).foregroundStyle(.secondary)
                    ForEach(viewModel.cards) { item in
                        ConceptCard(item: item) { viewModel.select(item) }
                    }
                }
                CodeBlock(code: "VStack { HStack { ... } }\n.padding()\n.background(.blue)")
            }
            .padding()
        }
    }

    private var dataTab: some View {
        List {
            Section("List with ForEach") {
                ForEach(viewModel.topics, id: \.self) { topic in
                    Label(topic, systemImage: "checkmark.circle")
                }
            }
            Section("Horizontal ScrollView + LazyHStack") {
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack {
                        ForEach(1...20, id: \.self) { number in
                            Text("\(number)").frame(width: 48, height: 48)
                                .background(.blue.opacity(0.15), in: RoundedRectangle(cornerRadius: 10))
                        }
                    }
                }
            }
            Section("Why lazy?") {
                Text("Lazy stacks create child views as they approach the visible region, which helps with long scrolling content.")
            }
        }
    }

    private var formTab: some View {
        Form {
            Section("Profile form") {
                TextField("Name", text: $viewModel.name)
                Picker("Experience", selection: $viewModel.level) {
                    ForEach(ExperienceLevel.allCases) { level in Text(level.rawValue).tag(level) }
                }
                Toggle("Notifications", isOn: $viewModel.notificationsEnabled)
            }
            Section("Current values") {
                Text(viewModel.formSummary)
            }
            Section("Form code") {
                CodeBlock(code: "Form {\n    TextField(\"Name\", text: $name)\n    Picker(\"Level\", selection: $level) { ... }\n}")
            }
        }
    }

    private var actionsTab: some View {
        List {
            Section("NavigationStack") {
                NavigationLink("Push a destination") {
                    Text("NavigationStack pushed this destination.")
                        .navigationTitle("Destination")
                }
            }
            Section("Presentations") {
                Button("Show sheet") { viewModel.isSheetPresented = true }
                Button("Show full-screen cover") { viewModel.isFullScreenPresented = true }
            }
            Section("Alerts and dialogs") {
                Button("Show alert") { viewModel.isAlertPresented = true }
                Button("Show confirmation dialog") { viewModel.isDialogPresented = true }
                Text(viewModel.lastAction).font(.caption).foregroundStyle(.secondary)
            }
            Section("State-driven presentation") {
                CodeBlock(code: ".sheet(isPresented: $showSheet) { DetailView() }\n.alert(\"Message\", isPresented: $showAlert) { ... }")
            }
            LessonDetailSection(details: LessonDetailsCatalog.swiftUIToolkit)
        }
    }

    private func badge(_ title: String, _ color: Color) -> some View {
        Text(title).padding(8).frame(maxWidth: .infinity).background(color.opacity(0.15), in: Capsule())
    }
}

private struct PresentationExample: View {
    @Environment(\.dismiss) private var dismiss
    let title: String
    let symbol: String

    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: symbol).font(.system(size: 56)).foregroundStyle(.blue)
            Text(title).font(.title.bold())
            Button("Dismiss") { dismiss() }.buttonStyle(.borderedProminent)
        }
        .padding()
    }
}
