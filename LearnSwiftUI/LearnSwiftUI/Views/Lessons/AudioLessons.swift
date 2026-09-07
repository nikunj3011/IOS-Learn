import SwiftUI

struct AudioPlayerLessonView: View {
    @StateObject private var viewModel = AudioPlayerLessonViewModel()
    var body: some View {
        List {
            Section("Generated local audio") {
                HStack { Button("Play tone", action: viewModel.play); Button("Stop", action: viewModel.stop) }.buttonStyle(.borderedProminent)
                Text(viewModel.status).foregroundStyle(.secondary)
                CodeBlock(code: "let player = try AVAudioPlayer(contentsOf: fileURL)\nplayer.prepareToPlay()\nplayer.play()")
            }
            LessonDetailSection(details: LessonDetailsCatalog.audioPlayer)
        }.navigationTitle("Audio Playback").navigationBarTitleDisplayMode(.inline).onDisappear(perform: viewModel.stop)
    }
}

struct AudioRecorderLessonView: View {
    @StateObject private var viewModel = AudioRecorderLessonViewModel()
    var body: some View {
        List {
            Section("Microphone recording") {
                HStack { Button("Record", action: viewModel.start); Button("Stop", action: viewModel.stop) }.buttonStyle(.borderedProminent)
                Text(viewModel.status).foregroundStyle(.secondary)
                CodeBlock(code: "let recorder = try AVAudioRecorder(url: url, settings: settings)\nrecorder.record()\nrecorder.stop()")
            }
            LessonDetailSection(details: LessonDetailsCatalog.audioRecorder)
        }.navigationTitle("Audio Recording").navigationBarTitleDisplayMode(.inline).onDisappear(perform: viewModel.stop)
    }
}

struct AudioEngineLessonView: View {
    @StateObject private var viewModel = AudioEngineLessonViewModel()
    var body: some View {
        List {
            Section("Live input level") {
                ProgressView(value: viewModel.level).tint(.green)
                HStack { Button("Start engine", action: viewModel.start); Button("Stop", action: viewModel.stop) }.buttonStyle(.borderedProminent)
                Text(viewModel.status).foregroundStyle(.secondary)
                CodeBlock(code: "let engine = AVAudioEngine()\nengine.inputNode.installTap(onBus: 0, bufferSize: 1024, format: format) { buffer, time in\n    // analyze or process buffer\n}\ntry engine.start()")
            }
            LessonDetailSection(details: LessonDetailsCatalog.audioEngine)
        }.navigationTitle("AVAudioEngine").navigationBarTitleDisplayMode(.inline).onDisappear(perform: viewModel.stop)
    }
}
