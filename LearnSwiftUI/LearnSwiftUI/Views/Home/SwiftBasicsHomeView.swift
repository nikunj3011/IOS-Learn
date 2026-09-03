import SwiftUI

struct SwiftBasicsHomeView: View {
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Start with the essentials").font(.title.bold())
                        Text("Change the controls, read the Swift, and watch the interface respond.")
                            .foregroundStyle(.secondary)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.vertical, 8)

                    LessonCard(number: 1, title: "Variables, constants & types", subtitle: "Store values and understand what kind of data they contain.", symbol: "shippingbox.fill", color: .blue) { ValuesLessonView() }
                    LessonCard(number: 2, title: "Control flow", subtitle: "Make decisions and repeat UI with if, switch, and loops.", symbol: "arrow.triangle.branch", color: .orange) { ControlFlowLessonView() }
                    LessonCard(number: 3, title: "Functions", subtitle: "Work with parameters, return values, and closures.", symbol: "function", color: .purple) { FunctionsLessonView() }
                    LessonCard(number: 4, title: "Optionals", subtitle: "Handle values that may be missing without crashes.", symbol: "questionmark.app.fill", color: .green) { OptionalsLessonView() }
                    LessonCard(number: 5, title: "Collections", subtitle: "Organize data with arrays, sets, and dictionaries.", symbol: "square.stack.3d.up.fill", color: .indigo) { CollectionsLessonView() }
                    LessonCard(number: 6, title: "Structs & classes", subtitle: "Compare value semantics with shared reference identity.", symbol: "square.on.square", color: .cyan) { SemanticsLessonView() }
                    LessonCard(number: 7, title: "Protocols", subtitle: "Define contracts that many different types can follow.", symbol: "checklist", color: .teal) { ProtocolsLessonView() }
                    LessonCard(number: 8, title: "Generics", subtitle: "Write reusable, type-safe code with placeholders.", symbol: "chevron.left.forwardslash.chevron.right", color: .pink) { GenericsLessonView() }
                    LessonCard(number: 9, title: "Enums", subtitle: "Model application state with associated values.", symbol: "point.3.connected.trianglepath.dotted", color: .mint) { EnumsLessonView() }
                    LessonCard(number: 10, title: "Error handling", subtitle: "Represent and recover from failures using throws and Result.", symbol: "exclamationmark.triangle.fill", color: .red) { ErrorHandlingLessonView() }
                    LessonCard(number: 11, title: "Closures", subtitle: "Understand captures and work that escapes to run later.", symbol: "curlybraces.square.fill", color: .purple) { ClosuresAdvancedLessonView() }
                    LessonCard(number: 12, title: "ARC", subtitle: "Manage class lifetimes with strong and weak ownership.", symbol: "link.circle.fill", color: .orange) { ARCLessonView() }
                    LessonCard(number: 13, title: "Concurrency", subtitle: "Run suspendable work using async, await, and Task.", symbol: "bolt.horizontal.circle.fill", color: .blue) { ConcurrencyLessonView() }
                    LessonCard(number: 14, title: "SwiftUI UI toolkit", subtitle: "Combine declarative UI, composition, layout, lists, forms, navigation, tabs, and presentations.", symbol: "swift", color: .red) { SwiftUIToolkitLessonView() }

                    categoryHeader("State Management", subtitle: "Control ownership and propagate changing data through SwiftUI.")
                    LessonCard(number: 25, title: "@State", subtitle: "Own local UI state inside a view.", symbol: "square.and.pencil", color: .blue) { LocalStateLessonView() }
                    LessonCard(number: 26, title: "@Binding", subtitle: "Give a child controlled access to parent state.", symbol: "link", color: .purple) { BindingLessonView() }
                    LessonCard(number: 27, title: "Observation", subtitle: "Drive UI using modern @Observable models.", symbol: "eye.fill", color: .orange) { ObservationLessonView() }
                    LessonCard(number: 28, title: "Environment", subtitle: "Propagate shared dependencies through the view tree.", symbol: "leaf.fill", color: .green) { EnvironmentLessonView() }

                    categoryHeader("App Architecture", subtitle: "Separate responsibilities so features stay testable and replaceable.")
                    LessonCard(number: 29, title: "MVVM", subtitle: "Separate view rendering from presentation logic.", symbol: "rectangle.2.swap", color: .blue) { MVVMLessonView() }
                    LessonCard(number: 30, title: "Feature architecture", subtitle: "Organize code around product features.", symbol: "square.grid.2x2.fill", color: .indigo) { FeatureArchitectureLessonView() }
                    LessonCard(number: 31, title: "Dependency injection", subtitle: "Supply dependencies instead of constructing them internally.", symbol: "arrow.down.to.line.compact", color: .purple) { DependencyInjectionLessonView() }
                    LessonCard(number: 32, title: "Repository", subtitle: "Hide data sources behind a stable abstraction.", symbol: "externaldrive.fill", color: .teal) { RepositoryLessonView() }
                }
                .padding()
            }
            .background(Color(.systemGroupedBackground))
            .navigationTitle("Swift Basics")
        }
    }

    private func categoryHeader(_ title: String, subtitle: String) -> some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(title).font(.title2.bold())
            Text(subtitle).font(.subheadline).foregroundStyle(.secondary)
        }
        .padding(.top, 12)
    }
}
