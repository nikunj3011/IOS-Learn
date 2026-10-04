import SwiftUI

struct AnimationLessonView: View {
    @StateObject private var viewModel = AnimationLessonViewModel()
    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    var body: some View {
        List {
            Section("State-driven animation") {
                RoundedRectangle(cornerRadius: 20)
                    .fill(.purple.gradient)
                    .frame(height: viewModel.isExpanded ? 180 : 72)
                    .overlay { Image(systemName: "swift").font(.largeTitle).foregroundStyle(.white) }
                Button(viewModel.isExpanded ? "Collapse" : "Expand") {
                    if reduceMotion { viewModel.toggle() }
                    else { withAnimation(.spring(response: 0.45, dampingFraction: 0.72), viewModel.toggle) }
                }
                .buttonStyle(.borderedProminent)
                CodeBlock(code: "withAnimation(.spring) {\n    viewModel.toggle()\n}\n// Also: .animation(animation, value: state)")
            }
            LessonDetailSection(details: LessonDetailsCatalog.animation)
        }
        .navigationTitle("Animation")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct GesturesLessonView: View {
    @StateObject private var viewModel = GesturesLessonViewModel()

    var body: some View {
        List {
            Section("Tap, drag, and magnify") {
                Text("Tap count: \(viewModel.taps)")
                RoundedRectangle(cornerRadius: 22)
                    .fill(.orange.gradient)
                    .frame(width: 130, height: 130)
                    .overlay { Image(systemName: "hand.draw.fill").font(.largeTitle).foregroundStyle(.white) }
                    .scaleEffect(viewModel.scale)
                    .offset(viewModel.offset)
                    .onTapGesture(perform: viewModel.registerTap)
                    .gesture(DragGesture().onChanged { viewModel.updateDrag($0.translation) }.onEnded { _ in withAnimation(.spring) { viewModel.finishDrag() } })
                    .simultaneousGesture(MagnifyGesture().onChanged { viewModel.updateScale($0.magnification) }.onEnded { _ in withAnimation(.spring) { viewModel.resetScale() } })
                    .frame(maxWidth: .infinity, minHeight: 220)
                    .accessibilityLabel("Interactive gesture card")
                    .accessibilityHint("Double tap to increase the tap count")
                CodeBlock(code: "DragGesture()\n    .onChanged { viewModel.updateDrag($0.translation) }\n    .onEnded { _ in viewModel.finishDrag() }")
            }
            LessonDetailSection(details: LessonDetailsCatalog.gestures)
        }
        .navigationTitle("Gestures")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct AccessibilityLessonView: View {
    @ScaledMetric(relativeTo: .body) private var iconSize = 44

    var body: some View {
        List {
            Section("Meaningful, adaptable content") {
                HStack(alignment: .top) {
                    Image(systemName: "checkmark.circle.fill")
                        .resizable().frame(width: iconSize, height: iconSize).foregroundStyle(.green)
                        .accessibilityHidden(true)
                    VStack(alignment: .leading) {
                        Text("Download complete").font(.headline)
                        Text("lesson-notes.pdf").foregroundStyle(.secondary)
                    }
                }
                .accessibilityElement(children: .combine)
                .accessibilityLabel("Download complete, lesson notes PDF")
                Button("Accessible action") { }
                    .accessibilityHint("Demonstrates an optional VoiceOver hint")
                CodeBlock(code: ".accessibilityElement(children: .combine)\n.accessibilityLabel(\"Download complete, lesson notes PDF\")\n@ScaledMetric var iconSize = 44")
            }
            LessonDetailSection(details: LessonDetailsCatalog.accessibility)
        }
        .navigationTitle("Accessibility")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct LocalizationLessonView: View {
    @State private var locale = Locale(identifier: "en_CA")
    private let locales = [Locale(identifier: "en_CA"), Locale(identifier: "fr_CA"), Locale(identifier: "ar")]

    var body: some View {
        List {
            Section("Locale-aware formatting") {
                Picker("Preview locale", selection: $locale) {
                    ForEach(locales, id: \.identifier) { Text($0.localizedString(forIdentifier: $0.identifier) ?? $0.identifier).tag($0) }
                }
                Text(12345.67, format: .currency(code: "CAD").locale(locale))
                Text(Date.now, format: .dateTime.weekday(.wide).month(.wide).day().year().locale(locale))
                CodeBlock(code: "Text(total, format: .currency(code: \"CAD\"))\nText(\"lesson_title\") // key from Localizable.xcstrings")
            }
            LessonDetailSection(details: LessonDetailsCatalog.localization)
        }
        .environment(\.locale, locale)
        .navigationTitle("Localization")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct UnitTestsLessonView: View {
    @StateObject private var viewModel = TestingLessonViewModel()

    var body: some View {
        List {
            Section("Testable logic") {
                TextField("Input", text: $viewModel.input)
                Button("Run logic", action: viewModel.validate).buttonStyle(.borderedProminent)
                Text(viewModel.result.isEmpty ? "Change the input, then run the logic." : viewModel.result).foregroundStyle(.secondary)
                CodeBlock(code: "func testShortInputIsRejected() {\n    let result = TestingLessonViewModel.validationMessage(for: \"Hi\")\n    XCTAssertEqual(result, \"Enter at least 3 characters\")\n}")
            }
            LessonDetailSection(details: LessonDetailsCatalog.unitTests)
        }
        .navigationTitle("Unit Tests")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct UITestsLessonView: View {
    var body: some View {
        List {
            Section("Critical user flow") {
                Label("Launch app", systemImage: "1.circle.fill")
                Label("Find control by identifier", systemImage: "2.circle.fill")
                Label("Interact and assert result", systemImage: "3.circle.fill")
                CodeBlock(code: "let app = XCUIApplication()\napp.launchArguments = [\"-ui-testing\"]\napp.launch()\napp.buttons[\"continueButton\"].tap()\nXCTAssertTrue(app.staticTexts[\"Home\"].waitForExistence(timeout: 2))")
            }
            LessonDetailSection(details: LessonDetailsCatalog.uiTests)
        }
        .navigationTitle("UI Tests")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct SwiftTestingLessonView: View {
    var body: some View {
        List {
            Section("Modern test APIs") {
                Label("@Test declares behavior", systemImage: "checkmark.circle")
                Label("#expect records an expectation", systemImage: "checkmark.circle")
                Label("arguments create parameterized coverage", systemImage: "checkmark.circle")
                CodeBlock(code: "import Testing\n\n@Test(\"Valid names\", arguments: [\"Swift\", \"Taylor\"])\nfunc acceptsValidName(_ name: String) {\n    #expect(Validator.isValid(name))\n}")
            }
            LessonDetailSection(details: LessonDetailsCatalog.swiftTesting)
        }
        .navigationTitle("Swift Testing")
        .navigationBarTitleDisplayMode(.inline)
    }
}
