import Foundation

final class DefaultImageDownloadService: ImageDownloadService {
    func fetchImages<T: Decodable>(requestDTO: PhotosRequestDTO) async throws -> Result<T, Error> {
        guard let fileURL = Bundle.main.url(forResource: "photos_\(requestDTO.page)", withExtension: "json") else {
            fatalError("Didn't find the file photos_\(requestDTO.page).json")
        }
        let data = try Data(contentsOf: fileURL)
        let decoder = JSONDecoder()
        let jsonData = try decoder.decode(T.self, from: data)
        return .success(jsonData)
    }
    
    func fetchImage(imageURL: URL) async throws -> (imageData: Data, urlResponse: URLResponse) {
        let urlRequest = URLRequest(url: imageURL)
        return try await URLSession.shared.data(for: urlRequest)
    }
}
