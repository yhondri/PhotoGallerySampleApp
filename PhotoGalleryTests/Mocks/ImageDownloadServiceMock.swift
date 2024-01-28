@testable import PhotoGallery
import Foundation

final class ImageDownloadServiceMock: ImageDownloadService {
    var failCalls: Bool = false
    var returnEmptyImageData: Bool = false
    var imageDonwloadError: ImageDownloaderError = .decodingData
    
    private(set) var didCallFetchImages = false
    private(set) var didCallFetchImage = false

    func fetchImages<T>(requestDTO: PhotoGallery.PhotosRequestDTO) async throws -> Result<T, Error> where T : Decodable {
        didCallFetchImages = true
        
        if failCalls {
            return .failure(ImageDownloaderError.decodingData)
        }
        
        return .success([PhotosResponseDTO.photo] as! T)
    }
    
    func fetchImage(imageURL: URL) async throws -> (imageData: Data, urlResponse: URLResponse) {   
        didCallFetchImage = true

        if failCalls {
            throw imageDonwloadError
        }
        
        let imageData = returnEmptyImageData ?  Data() : try getImageData()
        let urlResponse = HTTPURLResponse(url: URL(string: "https://www.google.com/")!,
                                          statusCode: 200,
                                          httpVersion: "1.1",
                                          headerFields: nil)!
        return (imageData: imageData, urlResponse: urlResponse)
    }
    
    private func getImageData() throws -> Data {
        guard let fileURL = Bundle(for: ImageDownloadServiceMock.self).url(forResource: "test_image",
                                                                           withExtension: "png") else {
            fatalError("Didn't find the picture test_image")
        }
        return try Data(contentsOf: fileURL)
    }
}
