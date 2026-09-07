import PhotosUI
import SwiftUI

struct AsyncImageLessonView: View {
    @State private var reloadID = 1
    private var url: URL { URL(string: "https://picsum.photos/600/400?lesson=\(reloadID)")! }

    var body: some View {
        List {
            Section("Remote image phases") {
                AsyncImage(url: url) { phase in
                    switch phase {
                    case .empty: ProgressView().frame(maxWidth: .infinity, minHeight: 220)
                    case .success(let image): image.resizable().scaledToFill().frame(height: 220).clipped()
                    case .failure: ContentUnavailableView("Image failed", systemImage: "wifi.exclamationmark")
                    @unknown default: EmptyView()
                    }
                }.clipShape(RoundedRectangle(cornerRadius: 16))
                Button("Load another image") { reloadID += 1 }
                CodeBlock(code: "AsyncImage(url: url) { phase in\n    switch phase {\n    case .empty: ProgressView()\n    case .success(let image): image.resizable()\n    case .failure: Image(systemName: \"exclamationmark\")\n    }\n}")
            }
            LessonDetailSection(details: LessonDetailsCatalog.asyncImage)
        }.navigationTitle("AsyncImage").navigationBarTitleDisplayMode(.inline)
    }
}

struct ImagePipelineLessonView: View {
    @StateObject private var viewModel = ImagePipelineLessonViewModel()

    var body: some View {
        List {
            Section("Download → decode → cache") {
                if let image = viewModel.image { Image(uiImage: image).resizable().scaledToFit().clipShape(RoundedRectangle(cornerRadius: 16)) }
                Button("Load through pipeline", action: viewModel.load).buttonStyle(.borderedProminent)
                Text(viewModel.status).font(.caption).foregroundStyle(.secondary)
                CodeBlock(code: "if let cached = cache.object(forKey: url) { return cached }\nlet (data, _) = try await session.data(from: url)\nlet image = UIImage(data: data)\ncache.setObject(image, forKey: url)")
            }
            LessonDetailSection(details: LessonDetailsCatalog.imagePipeline)
        }.navigationTitle("Image Pipeline").navigationBarTitleDisplayMode(.inline)
    }
}

struct PhotosLessonView: View {
    @State private var selection: PhotosPickerItem?
    @State private var image: UIImage?
    @State private var status = "Choose one photo"

    var body: some View {
        List {
            Section("Privacy-focused picker") {
                if let image { Image(uiImage: image).resizable().scaledToFit().clipShape(RoundedRectangle(cornerRadius: 16)) }
                PhotosPicker(selection: $selection, matching: .images) { Label("Choose photo", systemImage: "photo.on.rectangle") }
                    .buttonStyle(.borderedProminent)
                Text(status).font(.caption).foregroundStyle(.secondary)
            }
            Section("Transferable") { CodeBlock(code: "let data = try await item.loadTransferable(type: Data.self)\nlet image = UIImage(data: data)") }
            LessonDetailSection(details: LessonDetailsCatalog.photos)
        }
        .navigationTitle("Photos").navigationBarTitleDisplayMode(.inline)
        .onChange(of: selection) { _, item in
            Task {
                do {
                    guard let data = try await item?.loadTransferable(type: Data.self), let decoded = UIImage(data: data) else { return }
                    image = decoded; status = "Selected photo loaded"
                } catch { status = error.localizedDescription }
            }
        }
    }
}
