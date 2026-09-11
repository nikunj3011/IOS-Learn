import BackgroundTasks
import Combine
import CoreBluetooth
import CoreLocation
import CryptoKit
import Foundation
import HealthKit
import UserNotifications

final class CryptoKitLessonViewModel: ObservableObject {
    @Published var input = "Learn Swift securely"
    @Published private(set) var output = ""

    func hash() { output = SHA256.hash(data: Data(input.utf8)).map { String(format: "%02x", $0) }.joined() }
    func encrypt() {
        do {
            let key = SymmetricKey(size: .bits256)
            let sealed = try AES.GCM.seal(Data(input.utf8), using: key)
            output = sealed.combined?.base64EncodedString() ?? "Encrypted"
        } catch { output = error.localizedDescription }
    }
}

final class OAuthLessonViewModel: ObservableObject {
    @Published private(set) var verifier = "Generate a PKCE request"
    @Published private(set) var authorizationURL = ""

    func generate() {
        let bytes = (0..<32).map { _ in UInt8.random(in: 0...255) }
        verifier = Data(bytes).base64URLEncoded
        let challenge = Data(SHA256.hash(data: Data(verifier.utf8))).base64URLEncoded
        authorizationURL = "https://identity.example/authorize?response_type=code&code_challenge=\(challenge)&code_challenge_method=S256"
    }
}

private extension Data {
    var base64URLEncoded: String { base64EncodedString().replacingOccurrences(of: "+", with: "-").replacingOccurrences(of: "/", with: "_").replacingOccurrences(of: "=", with: "") }
}

@MainActor
final class NotificationsLessonViewModel: ObservableObject {
    @Published private(set) var status = "Permission not requested"
    func requestAndSchedule() {
        Task {
            do {
                let center = UNUserNotificationCenter.current()
                guard try await center.requestAuthorization(options: [.alert, .sound]) else { status = "Notifications denied"; return }
                let content = UNMutableNotificationContent(); content.title = "Swift lesson"; content.body = "Local notification delivered"
                let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false))
                try await center.add(request); status = "Scheduled for 5 seconds from now"
            } catch { status = error.localizedDescription }
        }
    }
}

final class DeepLinksLessonViewModel: ObservableObject {
    @Published var input = "learnswiftui://lesson/54"
    @Published private(set) var route = "No route parsed"
    func parse() {
        guard let url = URL(string: input), url.scheme == "learnswiftui", url.host == "lesson", let id = Int(url.pathComponents.last ?? "") else { route = "Invalid or unsupported URL"; return }
        route = "Navigate to lesson \(id)"
    }
}

@MainActor
final class BackgroundTasksLessonViewModel: ObservableObject {
    @Published private(set) var status = "No simulated background work"
    func simulate() {
        Task { status = "Background-style work started"; try? await Task.sleep(for: .seconds(1)); status = "Work completed and expiration respected" }
    }
}

final class LocationLessonViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    @Published private(set) var status = "Location not requested"
    private let manager = CLLocationManager()
    override init() { super.init(); manager.delegate = self }
    func request() { manager.requestWhenInUseAuthorization(); manager.requestLocation() }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) { guard let value = locations.last else { return }; status = String(format: "%.4f, %.4f", value.coordinate.latitude, value.coordinate.longitude) }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) { status = error.localizedDescription }
}

final class BluetoothLessonViewModel: NSObject, ObservableObject, CBCentralManagerDelegate {
    @Published private(set) var status = "Bluetooth manager not started"
    private var manager: CBCentralManager?
    func start() { manager = CBCentralManager(delegate: self, queue: nil); status = "Waiting for Bluetooth state" }
    func centralManagerDidUpdateState(_ central: CBCentralManager) { status = central.state == .poweredOn ? "Powered on—scanning briefly" : "State: \(central.state.rawValue)"; if central.state == .poweredOn { central.scanForPeripherals(withServices: nil); DispatchQueue.main.asyncAfter(deadline: .now() + 3) { central.stopScan(); self.status = "Scan stopped" } } }
}

final class HealthKitLessonViewModel: ObservableObject {
    @Published private(set) var status = HKHealthStore.isHealthDataAvailable() ? "Health data is available on this device" : "Health data is unavailable (common in some simulators)"
}
