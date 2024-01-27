import SwiftUI

enum PhotoState {
    case downloaded
    case missing
}

struct PhotoData {
    let id: String
    let photo: Photo
    let photoCache: PhotoCache?
    let photoState: PhotoState
}

extension PhotoData: Identifiable {}

extension PhotoData: Hashable {
    static func == (lhs: PhotoData, rhs: PhotoData) -> Bool {
        lhs.photo.id == rhs.photo.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(photo.id)
        hasher.combine(photoState)
    }
}

@Observable class PhotoGalleryListViewModel {

    private var photosRepository: PhotosRepository?
    private(set) var currentPage: Int = 0
    private(set) var totalPageCount: Int = 1
    var hasMorePages: Bool { currentPage < totalPageCount }
    var nextPage: Int { hasMorePages ? currentPage + 1 : currentPage }
    
    private(set) var photos: [PhotoData] = []
    
    func setDIContainer(_ photosDIContainer: PhotosDIContainer) {
        self.photosRepository = photosDIContainer.makePhotosRepository()
    }
    
    func loadNextPage() {
        Task {
            do {
                let result = try await photosRepository?.fetchPhotos(page: self.nextPage)
                switch result {
                case .success(let photoPage):
                    await updatePhotos(photoPage.photos)
                case .failure(let error):
                    debugPrint("Error loading photos ", error)
                case .none:
                    break
                }
            } catch {
                debugPrint("Error loading photos ", error)
            }
        }
    }
    
    private func updatePhotos(_ newPhotos: [Photo]) async {
        await MainActor.run {
            let photoDatas: [PhotoData] = newPhotos.map { photo in
                PhotoData(id: photo.id,
                          photo: photo,
                          photoCache: nil,
                          photoState: .missing)
            }
            photos.append(contentsOf: photoDatas)
        }
    }
    
    func downloadImage(photo: PhotoData) {
        Task {
            do {
                let result = try await photosRepository?.fetchImage(imageUrlString: photo.photo.urls.thumb)
                await onDidDownloadImage(image: result, photo: photo)
            } catch {
                
            }
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
