import Foundation

struct PhotoURLsDTO: Decodable {
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

extension PhotoURLsDTO {
    func toDomain() -> PhotoURLs {
        PhotoURLs(raw: raw,
                  full: full,
                  small: small,
                  thumb: thumb,
                  small_s3: small_s3)
    }
}
