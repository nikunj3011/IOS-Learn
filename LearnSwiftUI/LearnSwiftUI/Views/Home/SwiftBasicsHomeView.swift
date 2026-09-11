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

                    categoryHeader("Networking", subtitle: "Connect typed Swift models to remote HTTP and real-time services.")
                    LessonCard(number: 33, title: "Networking essentials", subtitle: "Combine URLSession, Codable, REST, file transfers, and WebSockets.", symbol: "network", color: .blue) { NetworkingLessonView() }

                    categoryHeader("Database", subtitle: "Persist structured app data using Apple frameworks or direct SQL.")
                    LessonCard(number: 38, title: "SwiftData", subtitle: "Modern Apple persistence with models and queries.", symbol: "cylinder.split.1x2.fill", color: .blue) { SwiftDataLessonView() }
                    LessonCard(number: 39, title: "Core Data", subtitle: "Managed object persistence for existing and advanced apps.", symbol: "square.stack.3d.up.fill", color: .orange) { CoreDataLessonView() }
                    LessonCard(number: 40, title: "SQLite", subtitle: "Understand tables, rows, SQL, and direct local databases.", symbol: "cylinder.fill", color: .purple) { SQLiteLessonView() }

                    categoryHeader("Storage", subtitle: "Choose storage based on whether data is a preference, secret, or file.")
                    LessonCard(number: 41, title: "UserDefaults", subtitle: "Persist small preferences and settings.", symbol: "switch.2", color: .blue) { UserDefaultsLessonView() }
                    LessonCard(number: 42, title: "Keychain", subtitle: "Protect tokens, passwords, and other secrets.", symbol: "key.fill", color: .yellow) { KeychainLessonView() }
                    LessonCard(number: 43, title: "FileManager", subtitle: "Read and write files in app-owned directories.", symbol: "folder.fill", color: .teal) { FileManagerLessonView() }

                    categoryHeader("Images, Video & Audio", subtitle: "Load, capture, play, record, and process media with Apple frameworks.")
                    LessonCard(number: 44, title: "AsyncImage", subtitle: "Load and display a remote image with phases.", symbol: "photo", color: .blue) { AsyncImageLessonView() }
                    LessonCard(number: 45, title: "Image pipeline", subtitle: "Download, decode, and cache images.", symbol: "photo.stack.fill", color: .indigo) { ImagePipelineLessonView() }
                    LessonCard(number: 46, title: "Photos", subtitle: "Select images from the photo library safely.", symbol: "photo.on.rectangle.angled", color: .pink) { PhotosLessonView() }
                    LessonCard(number: 47, title: "Camera", subtitle: "Control authorization and capture sessions.", symbol: "camera.fill", color: .orange) { CameraLessonView() }
                    LessonCard(number: 48, title: "Video playback", subtitle: "Play and control video with AVPlayer.", symbol: "play.rectangle.fill", color: .blue) { VideoPlayerLessonView() }
                    LessonCard(number: 49, title: "Video recording", subtitle: "Build an AVFoundation recording pipeline.", symbol: "video.fill", color: .red) { VideoRecordingLessonView() }
                    LessonCard(number: 50, title: "Audio playback", subtitle: "Play local audio using AVAudioPlayer.", symbol: "speaker.wave.2.fill", color: .purple) { AudioPlayerLessonView() }
                    LessonCard(number: 51, title: "Audio recording", subtitle: "Capture microphone audio using AVAudioRecorder.", symbol: "mic.fill", color: .red) { AudioRecorderLessonView() }
                    LessonCard(number: 52, title: "Audio engine", subtitle: "Inspect and process live audio buffers.", symbol: "waveform", color: .teal) { AudioEngineLessonView() }

                    categoryHeader("Security & Authentication", subtitle: "Protect credentials, encrypt data, and implement trusted sign-in flows.")
                    LessonCard(number: 53, title: "Keychain credentials", subtitle: "Store authentication credentials securely.", symbol: "key.viewfinder", color: .yellow) { SecurityKeychainLessonView() }
                    LessonCard(number: 54, title: "CryptoKit", subtitle: "Hash and encrypt data with modern cryptography.", symbol: "lock.shield.fill", color: .purple) { CryptoKitLessonView() }
                    LessonCard(number: 55, title: "OAuth & OpenID Connect", subtitle: "Understand authorization, PKCE, tokens, and SSO.", symbol: "person.badge.key.fill", color: .blue) { OAuthLessonView() }
                    LessonCard(number: 56, title: "Sign in with Apple", subtitle: "Authenticate using Apple's privacy-focused identity service.", symbol: "apple.logo", color: .primary) { SignInWithAppleLessonView() }

                    categoryHeader("System Integrations", subtitle: "Connect your app to notifications, hardware, location, health, and system surfaces.")
                    LessonCard(number: 57, title: "Notifications", subtitle: "Request permission and schedule local notifications.", symbol: "bell.badge.fill", color: .red) { NotificationsLessonView() }
                    LessonCard(number: 58, title: "Deep links", subtitle: "Parse URLs and navigate to app content.", symbol: "link.badge.plus", color: .blue) { DeepLinksLessonView() }
                    LessonCard(number: 59, title: "Background tasks", subtitle: "Schedule and manage bounded background work.", symbol: "clock.arrow.trianglehead.counterclockwise.rotate.90", color: .indigo) { BackgroundTasksLessonView() }
                    LessonCard(number: 60, title: "Location", subtitle: "Request authorization and receive Core Location updates.", symbol: "location.fill", color: .blue) { LocationLessonView() }
                    LessonCard(number: 61, title: "Maps", subtitle: "Display places and camera positions with MapKit.", symbol: "map.fill", color: .green) { MapsLessonView() }
                    LessonCard(number: 62, title: "Bluetooth", subtitle: "Discover nearby devices using CoreBluetooth.", symbol: "antenna.radiowaves.left.and.right", color: .blue) { BluetoothLessonView() }
                    LessonCard(number: 63, title: "HealthKit", subtitle: "Understand health authorization and queries.", symbol: "heart.text.square.fill", color: .pink) { HealthKitLessonView() }
                    LessonCard(number: 64, title: "Widgets", subtitle: "Build timeline-driven WidgetKit extensions.", symbol: "square.grid.2x2.fill", color: .cyan) { WidgetsLessonView() }
                    LessonCard(number: 65, title: "Live Activities", subtitle: "Show continuously updated activities with ActivityKit.", symbol: "livephoto", color: .orange) { LiveActivitiesLessonView() }
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
