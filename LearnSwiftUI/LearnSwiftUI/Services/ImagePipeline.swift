import Foundation
import UIKit

actor ImagePipeline {
    static let shared = ImagePipeline()
    private let cache = NSCache<NSURL, UIImage>()

    func image(for url: URL) async throws -> UIImage {
        if let cached = cache.object(forKey: url as NSURL) { return cached }
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let http = response as? HTTPURLResponse, 200..<300 ~= http.statusCode else { throw URLError(.badServerResponse) }
        guard let image = UIImage(data: data) else { throw URLError(.cannotDecodeContentData) }
        cache.setObject(image, forKey: url as NSURL)
        return image
    }
}
