import AVFoundation
import Combine
import Foundation
import UIKit

@MainActor
final class ImagePipelineLessonViewModel: ObservableObject {
    @Published private(set) var image: UIImage?
    @Published private(set) var status = "Image has not loaded"

    func load() {
        Task {
            status = "Downloading and decoding…"
            do {
                image = try await ImagePipeline.shared.image(for: URL(string: "https://picsum.photos/600/400")!)
                status = "Decoded image cached in memory"
            } catch { status = error.localizedDescription }
        }
    }
}

@MainActor
final class CameraLessonViewModel: ObservableObject {
    @Published private(set) var authorization = "Not requested"

    func requestAccess() {
        Task {
            let granted = await AVCaptureDevice.requestAccess(for: .video)
            authorization = granted ? "Camera access granted" : "Camera access denied"
        }
    }
}

@MainActor
final class VideoRecordingLessonViewModel: ObservableObject {
    @Published private(set) var status = "Permissions not checked"

    func checkPermissions() {
        Task {
            let camera = await AVCaptureDevice.requestAccess(for: .video)
            let microphone = await AVAudioApplication.requestRecordPermission()
            status = camera && microphone ? "Ready to configure movie output" : "Camera and microphone access are required"
        }
    }
}

@MainActor
final class AudioPlayerLessonViewModel: NSObject, ObservableObject, AVAudioPlayerDelegate {
    @Published private(set) var status = "Ready to generate a tone"
    private var player: AVAudioPlayer?

    func play() {
        do {
            player = try AVAudioPlayer(data: Self.toneWAV())
            player?.delegate = self
            player?.prepareToPlay()
            player?.play()
            status = "Playing generated 440 Hz WAV"
        } catch { status = error.localizedDescription }
    }

    func stop() { player?.stop(); status = "Playback stopped" }
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) { status = flag ? "Playback finished" : "Playback failed" }

    private static func toneWAV() -> Data {
        let sampleRate = 44_100, sampleCount = 22_050
        var samples = Data(capacity: sampleCount * 2)
        for index in 0..<sampleCount {
            var sample = Int16(sin(2 * .pi * 440 * Double(index) / Double(sampleRate)) * 8_000).littleEndian
            withUnsafeBytes(of: &sample) { samples.append(contentsOf: $0) }
        }
        var data = Data()
        func append<T>(_ value: T) { var value = value; withUnsafeBytes(of: &value) { data.append(contentsOf: $0) } }
        data.append("RIFF".data(using: .ascii)!); append(UInt32(36 + samples.count).littleEndian)
        data.append("WAVEfmt ".data(using: .ascii)!); append(UInt32(16).littleEndian); append(UInt16(1).littleEndian)
        append(UInt16(1).littleEndian); append(UInt32(sampleRate).littleEndian); append(UInt32(sampleRate * 2).littleEndian)
        append(UInt16(2).littleEndian); append(UInt16(16).littleEndian); data.append("data".data(using: .ascii)!)
        append(UInt32(samples.count).littleEndian); data.append(samples); return data
    }
}

@MainActor
final class AudioRecorderLessonViewModel: ObservableObject {
    @Published private(set) var status = "Ready to request microphone access"
    private var recorder: AVAudioRecorder?

    func start() {
        Task {
            guard await AVAudioApplication.requestRecordPermission() else { status = "Microphone access denied"; return }
            do {
                let url = FileManager.default.temporaryDirectory.appending(path: "lesson-recording.m4a")
                let settings: [String: Any] = [AVFormatIDKey: kAudioFormatMPEG4AAC, AVSampleRateKey: 44_100, AVNumberOfChannelsKey: 1, AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue]
                recorder = try AVAudioRecorder(url: url, settings: settings)
                recorder?.record(); status = "Recording to \(url.lastPathComponent)"
            } catch { status = error.localizedDescription }
        }
    }

    func stop() { recorder?.stop(); recorder = nil; status = "Recording stopped and file saved" }
}

@MainActor
final class AudioEngineLessonViewModel: ObservableObject {
    @Published private(set) var level: Float = 0
    @Published private(set) var status = "Engine stopped"
    private let engine = AVAudioEngine()

    func start() {
        Task {
            guard await AVAudioApplication.requestRecordPermission() else { status = "Microphone access denied"; return }
            let input = engine.inputNode
            let format = input.outputFormat(forBus: 0)
            input.installTap(onBus: 0, bufferSize: 1024, format: format) { [weak self] buffer, _ in
                guard let channel = buffer.floatChannelData?.pointee else { return }
                var sum: Float = 0
                for index in 0..<Int(buffer.frameLength) { sum += channel[index] * channel[index] }
                let rms = sqrt(sum / Float(max(buffer.frameLength, 1)))
                Task { @MainActor in self?.level = min(rms * 8, 1) }
            }
            do { try engine.start(); status = "Processing live input buffers" }
            catch { status = error.localizedDescription }
        }
    }

    func stop() { engine.inputNode.removeTap(onBus: 0); engine.stop(); level = 0; status = "Engine stopped" }
}
