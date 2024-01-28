import SwiftUI

@Observable class PhotoGalleryListViewModel {
    
    var hasMorePages: Bool { currentPage < totalPageCount }
    var nextPage: Int { hasMorePages ? currentPage + 1 : currentPage }
    private(set) var photos: [PhotoData] = []
    private var currentPage: Int = 0
    private var totalPageCount: Int = 1
    private var didMakeFirstPageCall = false
    private var photosRepository: PhotosRepository?
    
    func setDIContainer(_ photosDIContainer: PhotosDIContainer) {
        self.photosRepository = photosDIContainer.makePhotosRepository()
    }
    
    func loadNextPage(completion: (() -> Void)? = nil) {
        Task {
            do {
                let result = try await photosRepository?.fetchPhotos(page: nextPage)
                switch result {
                case .success(let photoPage):
                    await appendPage(photoPage)
                case .failure(let error):
                    debugPrint("Error loading photos ", error)
                case .none:
                    break
                }
            } catch {
                debugPrint("Error loading photos ", error)
            }
            
            completion?()
        }
    }
    
    private func appendPage(_ photoPage: PhotoPage) async {
        let newPhotos = photoPage.photos
        await MainActor.run {
            let photoDatas: [PhotoData] = newPhotos.map { photo in
                PhotoData(id: photo.id,
                          photo: photo,
                          photoCache: nil,
                          photoState: .missing)
            }
            photos.append(contentsOf: photoDatas)
            currentPage = photoPage.page
            totalPageCount = photoPage.totalPages
        }
    }
    
    func downloadImage(photo: PhotoData, completion: (() -> Void)? = nil) {
        Task {
            do {
                let result = try await photosRepository?.fetchImage(imageUrlString: photo.photo.urls.thumb)
                await onDidDownloadImage(image: result, photo: photo)
            } catch {
                debugPrint("Error loading images")
            }
            
            completion?()
        }
    }
    
    private func onDidDownloadImage(image: PhotoCache?, photo: PhotoData) async {
        guard let image else {
            return
        }
        guard let index = photos.firstIndex(of: photo) else {
            return
        }
        let updatedPhoto = PhotoData(id: photo.id,
                                     photo: photo.photo,
                                         photoCache: image,
                                         photoState: .downloaded)
        await MainActor.run {
            photos[index] = updatedPhoto
        }
    }
}
