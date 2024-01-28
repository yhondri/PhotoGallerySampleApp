@testable import PhotoGallery

final class PhotosDIContainerMock: PhotosDIContainer {
    private let photosRepository: PhotosRepositoryMock
    
    init(photosRepository: PhotosRepositoryMock) {
        self.photosRepository = photosRepository
    }
    
    func makePhotosRepository() -> PhotosRepository {
        photosRepository
    }
}
