@testable import PhotoGallery
import SwiftUI

final class PhotosRepositoryMock: PhotosRepository {
    var throwErrors: Bool = false
    var didCallFetchPhotos = false
    var didCallFetcImage = false
    let photoPage = PhotoPage(page: 1, totalPages: 1, photos: Photo.getMockPhotos())
    
    func fetchPhotos(page: Int) async throws -> Result<PhotoPage, Error> {
        didCallFetchPhotos = true
        if throwErrors {
            throw ImageDownloaderError.invalidServerResponse
        }
        return .success(photoPage)
    }
    
    func fetchImage(imageUrlString: String) async throws -> PhotoCache? {
        didCallFetcImage = true
        if throwErrors {
            throw ImageDownloaderError.invalidServerResponse
        }
        return PhotoCache(url: imageUrlString, image: Image("arrow.down.circle.dotted"))
    }
}
