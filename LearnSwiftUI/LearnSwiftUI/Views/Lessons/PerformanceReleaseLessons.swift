import SwiftUI

struct InstrumentsLessonView: View {
    var body: some View {
        GuidanceLessonView(
            title: "Instruments",
            section: "Evidence-first workflow",
            steps: ["Set a measurable target", "Profile a Release build", "Reproduce the same journey", "Inspect the call tree or timeline", "Change one cause and measure again"],
            code: "Product → Profile\nTime Profiler: CPU call stacks\nAllocations + Leaks: memory\nNetwork: requests and transfers",
            details: LessonDetailsCatalog.instruments
        )
    }
}

struct LazyRenderingLessonView: View {
    private let columns = [GridItem(.adaptive(minimum: 72))]

    var body: some View {
        List {
            Section("Lazy grid of 1,000 values") {
                ScrollView {
                    LazyVGrid(columns: columns) {
                        ForEach(1...1_000, id: \.self) { number in
                            Text("\(number)").frame(maxWidth: .infinity).padding(.vertical, 8).background(.blue.opacity(0.12), in: RoundedRectangle(cornerRadius: 8))
                        }
                    }
                }
                .frame(height: 280)
                CodeBlock(code: "ScrollView {\n    LazyVGrid(columns: columns) {\n        ForEach(items) { item in Row(item: item) }\n    }\n}")
            }
            LessonDetailSection(details: LessonDetailsCatalog.lazyRendering)
        }
        .navigationTitle("Lazy Rendering")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct MemoryPerformanceLessonView: View {
    var body: some View {
        GuidanceLessonView(title: "Memory", section: "Memory audit", steps: ["Repeat navigation and watch the baseline", "Inspect the Memory Graph", "Follow unexpected retain paths", "Check image dimensions and caches", "Fix ownership, cancel work, and re-profile"], code: "final class Coordinator {\n    weak var delegate: CoordinatorDelegate?\n}\n\n// Downsample large images near display size.\n// Bound caches and remove observers/taps.", details: LessonDetailsCatalog.memoryPerformance)
    }
}

struct LoggingLessonView: View {
    @StateObject private var viewModel = LoggingLessonViewModel()

    var body: some View {
        List {
            Section("Structured OSLog event") {
                Button("Record sample event", action: viewModel.recordSampleEvent).buttonStyle(.borderedProminent)
                Text(viewModel.status).foregroundStyle(.secondary)
                CodeBlock(code: "let logger = Logger(subsystem: Bundle.main.bundleIdentifier!, category: \"network\")\nlogger.error(\"Request failed: \\(errorCode, privacy: .public)\")\n// Tokens and personal values must remain private.")
            }
            LessonDetailSection(details: LessonDetailsCatalog.logging)
        }
        .navigationTitle("Logging")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct CrashReportingLessonView: View {
    var body: some View {
        GuidanceLessonView(title: "Crash Reporting", section: "Production triage", steps: ["Collect the crash and exact version", "Symbolicate using its archive and dSYM", "Group matching stack traces", "Reproduce and identify the root cause", "Fix, test, release, and monitor"], code: "// Never intentionally crash production to test reporting.\n// Upload dSYMs from the matching archive.\n// Add privacy-safe breadcrumbs around important state changes.", details: LessonDetailsCatalog.crashReporting)
    }
}

struct XcodeBuildLessonView: View {
    var body: some View {
        GuidanceLessonView(title: "Xcode Builds", section: "Build structure", steps: ["Target: the product and its files", "Scheme: build/run/test/profile/archive actions", "Configuration: Debug, Release, or environment settings", "xcconfig: maintainable build-setting values", "Archive: distributable Release output"], code: "// Example xcconfig\nAPI_BASE_URL = https://api.example.com\nSWIFT_ACTIVE_COMPILATION_CONDITIONS = $(inherited) PRODUCTION", details: LessonDetailsCatalog.xcodeBuilds)
    }
}

struct SPMLessonView: View {
    var body: some View {
        GuidanceLessonView(title: "Swift Package Manager", section: "Dependency workflow", steps: ["Evaluate ownership, license, and maintenance", "Choose an intentional version rule", "Add the product only to targets that need it", "Commit Package.resolved for the app", "Review changes before updating"], code: ".package(url: \"https://example.com/library.git\", from: \"2.1.0\")\n\n.target(\n    name: \"Feature\",\n    dependencies: [.product(name: \"Library\", package: \"library\")]\n)", details: LessonDetailsCatalog.spm)
    }
}

struct SigningLessonView: View {
    var body: some View {
        GuidanceLessonView(title: "Signing", section: "Everything must agree", steps: ["Bundle identifier ↔ App ID", "Capabilities ↔ entitlements", "Certificate ↔ developer or distribution identity", "Provisioning profile ↔ app, identity, and devices", "Every extension target signs independently"], code: "App target\n  Bundle ID + entitlements\n        ↓\nProvisioning profile\n  App ID + certificate + allowed devices/capabilities", details: LessonDetailsCatalog.signing)
    }
}

struct TestFlightLessonView: View {
    var body: some View {
        GuidanceLessonView(title: "TestFlight", section: "Beta pipeline", steps: ["Archive and validate a Release build", "Upload it to App Store Connect", "Wait for processing and answer compliance questions", "Assign internal or external tester groups", "Collect feedback and promote only a verified candidate"], code: "Version: 1.4\nBuild: 27  // must increase per upload\n\nTest notes:\n• What changed\n• What testers should verify\n• Known limitations", details: LessonDetailsCatalog.testFlight)
    }
}

struct AppStoreReleaseLessonView: View {
    var body: some View {
        GuidanceLessonView(title: "App Store Release", section: "Production checklist", steps: ["Freeze and test the release candidate", "Validate archive, metadata, privacy, and screenshots", "Submit with complete review information", "Choose manual, automatic, or phased release", "Monitor crashes, reviews, analytics, and backend health"], code: "Release candidate → Archive → Validate → Upload\n        ↓\nApp Store Connect metadata + privacy\n        ↓\nReview → controlled release → monitoring", details: LessonDetailsCatalog.appStoreRelease)
    }
}

private struct GuidanceLessonView: View {
    let title: String
    let section: String
    let steps: [String]
    let code: String
    let details: LessonDetails

    var body: some View {
        List {
            Section(section) {
                ForEach(Array(steps.enumerated()), id: \.offset) { index, step in
                    Label(step, systemImage: "\(index + 1).circle.fill")
                }
                CodeBlock(code: code)
            }
            LessonDetailSection(details: details)
        }
        .navigationTitle(title)
        .navigationBarTitleDisplayMode(.inline)
    }
}
