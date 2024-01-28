@testable import PhotoGallery

extension PhotoData {
    static let photoData = PhotoData(id: "1",
                                     photo: Photo.getMockPhotos().first!,
                                     photoCache: nil,
                                     photoState: .missing)
}
