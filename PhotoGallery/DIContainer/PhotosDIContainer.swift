import Foundation

protocol PhotosDIContainer {
    func makePhotosRepository() -> PhotosRepository
}

final class DefaultPhotosDIContainer: PhotosDIContainer {
    private let imageDownloadService: ImageDownloadService
    init(imageDownloadService: ImageDownloadService = DefaultImageDownloadService()) {
        self.imageDownloadService = imageDownloadService
    }
    
    func makePhotosRepository() -> PhotosRepository {
        DefaultPhotosRepository(imageDownloadService: imageDownloadService)
    }
}
