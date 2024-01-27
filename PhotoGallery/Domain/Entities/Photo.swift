import Foundation

struct Photo {
    let id: String
    let photoDescription: String?
    let urls: PhotoURLs
}

extension Photo: Identifiable {}

struct PhotoURLs {
    let raw: String
    let full: String
    let small: String
    let thumb: String
    let small_s3: String
    
    private enum CodingKeys: String, CodingKey {
        case raw
        case full
        case small
        case thumb
        case small_s3
    }
}
