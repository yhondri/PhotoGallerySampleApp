import Foundation

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
