import MapKit
import SwiftUI

struct NotificationsLessonView: View {
    @StateObject private var viewModel = NotificationsLessonViewModel()
    var body: some View { lessonList("Permission and local scheduling", status: viewModel.status, action: ("Request + schedule", viewModel.requestAndSchedule), code: "let granted = try await center.requestAuthorization(options: [.alert, .sound])\ntry await center.add(notificationRequest)", details: LessonDetailsCatalog.notifications).navigationTitle("Notifications") }
}

struct DeepLinksLessonView: View {
    @StateObject private var viewModel = DeepLinksLessonViewModel()
    var body: some View {
        List {
            Section("URL → typed route") { TextField("Deep link", text: $viewModel.input).textInputAutocapitalization(.never); Button("Parse URL", action: viewModel.parse).buttonStyle(.borderedProminent); Text(viewModel.route); CodeBlock(code: ".onOpenURL { url in\n    router.navigate(to: Route(url: url))\n}") }
            LessonDetailSection(details: LessonDetailsCatalog.deepLinks)
        }.navigationTitle("Deep Links").navigationBarTitleDisplayMode(.inline)
    }
}

struct BackgroundTasksLessonView: View {
    @StateObject private var viewModel = BackgroundTasksLessonViewModel()
    var body: some View { lessonList("Bounded background work", status: viewModel.status, action: ("Simulate task", viewModel.simulate), code: "BGTaskScheduler.shared.register(forTaskWithIdentifier: identifier, using: nil) { task in\n    task.expirationHandler = { work.cancel() }\n    task.setTaskCompleted(success: true)\n}", details: LessonDetailsCatalog.backgroundTasks).navigationTitle("Background Tasks") }
}

struct LocationLessonView: View {
    @StateObject private var viewModel = LocationLessonViewModel()
    var body: some View { lessonList("When-in-use location", status: viewModel.status, action: ("Request location", viewModel.request), code: "manager.requestWhenInUseAuthorization()\nmanager.requestLocation()", details: LessonDetailsCatalog.location).navigationTitle("Core Location") }
}

struct MapsLessonView: View {
    private let coordinate = CLLocationCoordinate2D(latitude: 46.0878, longitude: -64.7782)
    var body: some View {
        List {
            Section("SwiftUI Map") { Map(initialPosition: .region(MKCoordinateRegion(center: coordinate, span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)))) { Marker("Moncton", coordinate: coordinate) }.frame(height: 280).clipShape(RoundedRectangle(cornerRadius: 16)); CodeBlock(code: "Map(position: $position) {\n    Marker(\"Place\", coordinate: coordinate)\n}") }
            LessonDetailSection(details: LessonDetailsCatalog.maps)
        }.navigationTitle("MapKit").navigationBarTitleDisplayMode(.inline)
    }
}

struct BluetoothLessonView: View {
    @StateObject private var viewModel = BluetoothLessonViewModel()
    var body: some View { lessonList("Central manager state", status: viewModel.status, action: ("Start 3-second scan", viewModel.start), code: "central.scanForPeripherals(withServices: [serviceUUID])\n// connect → discover services → discover characteristics", details: LessonDetailsCatalog.bluetooth).navigationTitle("CoreBluetooth") }
}

struct HealthKitLessonView: View {
    @StateObject private var viewModel = HealthKitLessonViewModel()
    var body: some View { lessonList("Health capability", status: viewModel.status, action: nil, code: "let steps = HKQuantityType(.stepCount)\ntry await healthStore.requestAuthorization(toShare: [], read: [steps])", details: LessonDetailsCatalog.healthKit).navigationTitle("HealthKit") }
}

struct WidgetsLessonView: View {
    var body: some View { lessonList("Extension timeline", status: "WidgetKit requires a Widget Extension target", action: nil, code: "struct Provider: TimelineProvider { ... }\nstruct LessonWidget: Widget {\n    var body: some WidgetConfiguration { StaticConfiguration(...) }\n}", details: LessonDetailsCatalog.widgets).navigationTitle("WidgetKit") }
}

struct LiveActivitiesLessonView: View {
    var body: some View { lessonList("Activity lifecycle", status: "Activity UI belongs in a Widget Extension", action: nil, code: "let activity = try Activity.request(attributes: attributes, content: content)\nawait activity.update(updatedContent)\nawait activity.end(finalContent, dismissalPolicy: .default)", details: LessonDetailsCatalog.liveActivities).navigationTitle("Live Activities") }
}

@ViewBuilder
private func lessonList(_ section: String, status: String, action: (String, () -> Void)?, code: String, details: LessonDetails) -> some View {
    List {
        Section(section) {
            if let action { Button(action.0, action: action.1).buttonStyle(.borderedProminent) }
            Text(status).foregroundStyle(.secondary)
            CodeBlock(code: code)
        }
        LessonDetailSection(details: details)
    }.navigationBarTitleDisplayMode(.inline)
}
