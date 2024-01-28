import Foundation

protocol ImageDownloadService {
    func fetchImages<T: Decodable>(requestDTO: PhotosRequestDTO) async throws -> Result<T, Error>
    func fetchImage(imageURL: URL) async throws -> (imageData: Data, urlResponse: URLResponse)
}
