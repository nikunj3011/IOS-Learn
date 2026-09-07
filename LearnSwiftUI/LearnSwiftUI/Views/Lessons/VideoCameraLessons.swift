import AVFoundation
import AVKit
import SwiftUI

struct CameraLessonView: View {
    @StateObject private var viewModel = CameraLessonViewModel()
    var body: some View {
        List {
            Section("Camera authorization") {
                Button("Request camera access", action: viewModel.requestAccess).buttonStyle(.borderedProminent)
                Text(viewModel.authorization).foregroundStyle(.secondary)
            }
            Section("Capture session") { CodeBlock(code: "let session = AVCaptureSession()\nlet device = AVCaptureDevice.default(for: .video)!\nlet input = try AVCaptureDeviceInput(device: device)\nsession.addInput(input)\nsession.addOutput(AVCapturePhotoOutput())") }
            LessonDetailSection(details: LessonDetailsCatalog.camera)
        }.navigationTitle("Camera").navigationBarTitleDisplayMode(.inline)
    }
}

struct VideoPlayerLessonView: View {
    @State private var player = AVPlayer(url: URL(string: "https://storage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4")!)
    var body: some View {
        List {
            Section("AVPlayer playback") {
                VideoPlayer(player: player).frame(height: 220).clipShape(RoundedRectangle(cornerRadius: 16))
                HStack { Button("Play") { player.play() }; Button("Pause") { player.pause() } }.buttonStyle(.bordered)
                CodeBlock(code: "let player = AVPlayer(url: videoURL)\nVideoPlayer(player: player)\nplayer.play()")
            }
            LessonDetailSection(details: LessonDetailsCatalog.videoPlayer)
        }.navigationTitle("Video Playback").navigationBarTitleDisplayMode(.inline).onDisappear { player.pause() }
    }
}

struct VideoRecordingLessonView: View {
    @StateObject private var viewModel = VideoRecordingLessonViewModel()
    var body: some View {
        List {
            Section("Capture requirements") {
                Button("Check camera + microphone", action: viewModel.checkPermissions).buttonStyle(.borderedProminent)
                Text(viewModel.status).foregroundStyle(.secondary)
            }
            Section("Movie output") { CodeBlock(code: "let session = AVCaptureSession()\nlet output = AVCaptureMovieFileOutput()\nsession.addOutput(output)\noutput.startRecording(to: url, recordingDelegate: delegate)") }
            Section("Editing") { CodeBlock(code: "let composition = AVMutableComposition()\n// Insert time ranges from source tracks\nlet export = AVAssetExportSession(asset: composition, presetName: preset)") }
            LessonDetailSection(details: LessonDetailsCatalog.videoRecording)
        }.navigationTitle("Video Recording").navigationBarTitleDisplayMode(.inline)
    }
}
