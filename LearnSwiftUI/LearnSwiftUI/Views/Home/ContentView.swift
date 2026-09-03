import SwiftUI

struct ContentView: View {
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

                    LessonCard(number: 1, title: "Variables, constants & types", subtitle: "Store values and understand what kind of data they contain.", symbol: "shippingbox.fill", color: .blue) {
                        ValuesLessonView()
                    }

                    LessonCard(number: 2, title: "Control flow", subtitle: "Make decisions and repeat UI with if, switch, and loops.", symbol: "arrow.triangle.branch", color: .orange) {
                        ControlFlowLessonView()
                    }

                    LessonCard(number: 3, title: "Functions", subtitle: "Work with parameters, return values, and closures.", symbol: "function", color: .purple) {
                        FunctionsLessonView()
                    }

                    LessonCard(number: 4, title: "Optionals", subtitle: "Handle values that may be missing without crashes.", symbol: "questionmark.app.fill", color: .green) {
                        OptionalsLessonView()
                    }

                    LessonCard(number: 5, title: "Collections", subtitle: "Organize data with arrays, sets, and dictionaries.", symbol: "square.stack.3d.up.fill", color: .indigo) {
                        CollectionsLessonView()
                    }

                    LessonCard(number: 6, title: "Structs & classes", subtitle: "Compare value semantics with shared reference identity.", symbol: "square.on.square", color: .cyan) {
                        SemanticsLessonView()
                    }

                    LessonCard(number: 7, title: "Protocols", subtitle: "Define contracts that many different types can follow.", symbol: "checklist", color: .teal) {
                        ProtocolsLessonView()
                    }

                    LessonCard(number: 8, title: "Generics", subtitle: "Write reusable, type-safe code with placeholders.", symbol: "chevron.left.forwardslash.chevron.right", color: .pink) {
                        GenericsLessonView()
                    }

                    LessonCard(number: 9, title: "Enums", subtitle: "Model application state with associated values.", symbol: "point.3.connected.trianglepath.dotted", color: .mint) {
                        EnumsLessonView()
                    }

                    LessonCard(number: 10, title: "Error handling", subtitle: "Represent and recover from failures using throws and Result.", symbol: "exclamationmark.triangle.fill", color: .red) {
                        ErrorHandlingLessonView()
                    }

                    LessonCard(number: 11, title: "Closures", subtitle: "Understand captures and work that escapes to run later.", symbol: "curlybraces.square.fill", color: .purple) {
                        ClosuresAdvancedLessonView()
                    }

                    LessonCard(number: 12, title: "ARC", subtitle: "Manage class lifetimes with strong and weak ownership.", symbol: "link.circle.fill", color: .orange) {
                        ARCLessonView()
                    }

                    LessonCard(number: 13, title: "Concurrency", subtitle: "Run suspendable work using async, await, and Task.", symbol: "bolt.horizontal.circle.fill", color: .blue) {
                        ConcurrencyLessonView()
                    }

                    LessonCard(number: 14, title: "Declarative SwiftUI", subtitle: "Describe the interface as a function of state.", symbol: "swift", color: .red) {
                        DeclarativeUILessonView()
                    }

                    LessonCard(number: 15, title: "View composition", subtitle: "Build screens from small reusable views.", symbol: "rectangle.3.group.fill", color: .indigo) {
                        ViewCompositionLessonView()
                    }
                }
                .padding()
            }
            .background(Color(.systemGroupedBackground))
            .navigationTitle("Swift Basics")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View { ContentView() }
}
