import Foundation
import SwiftUI

class DefaultPhotosRepository: PhotosRepository {
    private let serialQueueForImages: DispatchQueue = DispatchQueue(label: "com.yhondri.ImageCache.queue")
    private lazy var photosCache: [PhotoKey: PhotoCache] = [:]
    private let imageDownloadService: ImageDownloadService
    private typealias PhotoKey = String

    init(imageDownloadService: ImageDownloadService) {
        self.imageDownloadService = imageDownloadService
    }
    
    private var pageCounter = 0
    
    func fetchPhotos(page: Int) async throws -> Result<PhotoPage, Error> {
        let photosDTO = PhotosRequestDTO(page: page)
        let result: Result<[PhotosResponseDTO], Error> = try await imageDownloadService.fetchImages(requestDTO: photosDTO)
        
        switch result {
        case .success(let photosDTO):
            let photos = photosDTO.toDomain()
            let photoPage = PhotoPage(page: page, totalPages: 3, photos: photos)
            return .success(photoPage)
        case .failure(let error):
            return .failure(error)
        }
    }

    func fetchImage(imageUrlString: String) async throws -> PhotoCache? {
        if let image = getCachedImageFrom(urlString: imageUrlString) {
            return image
        } else {
            guard let imageUrl = URL(string: imageUrlString) else {
                return nil
            }
            
            let (data, response) = try await imageDownloadService.fetchImage(imageURL: imageUrl)
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                throw ImageDownloaderError.invalidServerResponse
            }
            guard let imageUIKit = UIImage(data: data) else {
                throw ImageDownloaderError.decodingData
            }
            
            let image = Image(uiImage: imageUIKit)
            let photoCache: PhotoCache = PhotoCache(url: imageUrlString, image: image)

            // Store the downloaded image in cache
            self.serialQueueForImages.sync(flags: .barrier) {
                photosCache[imageUrlString] = photoCache
            }

            return photoCache
        }
    }
    
    private func getCachedImageFrom(urlString: String) -> PhotoCache? {
        // Reading from the dictionary should happen in the thread-safe manner.
        self.serialQueueForImages.sync(flags: .barrier) {
            return photosCache[urlString]
        }
    }
}

