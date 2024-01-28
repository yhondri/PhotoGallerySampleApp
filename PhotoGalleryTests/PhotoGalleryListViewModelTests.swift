import XCTest
import SwiftUI
@testable import PhotoGallery

final class PhotoGalleryListViewModelTests: XCTestCase {
    private var viewModel: PhotoGalleryListViewModel!
    private var photosRepositoryMock: PhotosRepositoryMock!
    
    override func setUpWithError() throws {
        viewModel = PhotoGalleryListViewModel()
    }

    override func tearDownWithError() throws {
        viewModel = nil
        photosRepositoryMock = nil
    }

    private func givenPhotoRepositoryWithoutErrors() {
        photosRepositoryMock = PhotosRepositoryMock()
        let photosDIContainerMock = PhotosDIContainerMock(photosRepository: photosRepositoryMock)
        viewModel.setDIContainer(photosDIContainerMock)
    }
    
    private func whenViewModelLoadNextPage() async {
        let loadNextPageExpectation = expectation(description: "Next page should be loaded")
        viewModel.loadNextPage {
            loadNextPageExpectation.fulfill()
        }
        await fulfillment(of: [loadNextPageExpectation])
    }
    
    func testViewModelCallFetchPhotosWhenLoadNextPage() async {
        givenPhotoRepositoryWithoutErrors()
        await whenViewModelLoadNextPage()
        XCTAssertTrue(photosRepositoryMock.didCallFetchPhotos)
    }
    
    func testViewModelAppendNextPageAfterFetchPhotosSuccefully() async {
        givenPhotoRepositoryWithoutErrors()
        await whenViewModelLoadNextPage()
        XCTAssertEqual(viewModel.photos.count, photosRepositoryMock.photoPage.photos.count)
    }
    
    func testViewModelHasNotMorePagesWhenItHasLoadedAllAvailablePages() async {
        givenPhotoRepositoryWithoutErrors()
        await whenViewModelLoadNextPage()
        XCTAssertFalse(viewModel.hasMorePages)
    }
    
    private func whenViewModelCallFetchImage() async {
        let loadPhotoExpectation = expectation(description: "Download photo should be called")
        viewModel.downloadImage(photo: PhotoData.photoData) {
            loadPhotoExpectation.fulfill()
        }
        await fulfillment(of: [loadPhotoExpectation])
    }
    
    func testFetchImageIsCalledWhenViewLoadAPhoto() async {
        givenPhotoRepositoryWithoutErrors()
        await whenViewModelCallFetchImage()
        XCTAssertTrue(photosRepositoryMock.didCallFetcImage)
    }
    
    func testViewModelUpdatePhotoStateWhenDownloadPhoto() async {
        givenPhotoRepositoryWithoutErrors()
        await whenViewModelLoadNextPage()
        await whenViewModelCallFetchImage()
        let photoUpdated = viewModel.photos.first(where: { $0.photoState == .downloaded })
        XCTAssertEqual(photoUpdated?.id, "1")
    }
}
