import XCTest
@testable import PhotoGallery

final class DefaultPhotosRepositoryTests: XCTestCase {
    private var imageDownloadServiceMock: ImageDownloadServiceMock!
    private var defaultPhotosRepository: DefaultPhotosRepository!
    
    override func setUpWithError() throws {
        imageDownloadServiceMock = ImageDownloadServiceMock()
        defaultPhotosRepository = DefaultPhotosRepository(imageDownloadService: imageDownloadServiceMock)
    }

    override func tearDownWithError() throws {
        defaultPhotosRepository = nil
        imageDownloadServiceMock = nil
    }
    
    func testRepositoryCallsServicesFetchImages() async throws {
        let _ = try await defaultPhotosRepository.fetchPhotos(page: 1)
        XCTAssertTrue(imageDownloadServiceMock.didCallFetchImages)
    }
    
    func testRepositoryCallsServicesFetchImage() async throws {
        let _ = try await defaultPhotosRepository.fetchImage(imageUrlString: PhotosResponseDTO.photoURLs)
        XCTAssertTrue(imageDownloadServiceMock.didCallFetchImage)
    }
    
    func testReturnInvalidServerResponseErrorWhenTheServerREsponseIsNotValid() async throws {
        imageDownloadServiceMock.failCalls = true
        imageDownloadServiceMock.imageDonwloadError = .invalidServerResponse
        
        await assertThrowsAsyncError(try await defaultPhotosRepository.fetchImage(imageUrlString: PhotosResponseDTO.photoURLs)) { error in
            guard let error = error as? ImageDownloaderError else {
                XCTFail("Unexpected error type")
                return
            }
            XCTAssertEqual(error, ImageDownloaderError.invalidServerResponse)
        }
    }
    
    func testReturnDecodingDataErrorWhenTheDataIsNotValid() async throws {
        imageDownloadServiceMock.returnEmptyImageData = true
        
        await assertThrowsAsyncError(try await defaultPhotosRepository.fetchImage(imageUrlString: PhotosResponseDTO.photoURLs)) { error in
            guard let error = error as? ImageDownloaderError else {
                XCTFail("Unexpected error type")
                return
            }
            XCTAssertEqual(error, ImageDownloaderError.decodingData)
        }
    }
}
