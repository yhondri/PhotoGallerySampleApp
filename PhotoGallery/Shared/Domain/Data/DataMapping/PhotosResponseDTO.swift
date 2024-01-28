import Foundation

struct PhotosResponseDTO: Decodable {
    let id: String
    let photoDescription: String?
    let urls: PhotoURLsDTO
    
    private enum CodingKeys: String, CodingKey {
        case id
        case photoDescription = "description"
        case urls
    }
}

extension PhotosResponseDTO {
    func toDomain() -> Photo {
        Photo(id: id, 
              photoDescription: photoDescription,
              urls: urls.toDomain())
    }
}

extension Array where Element == PhotosResponseDTO {
    func toDomain(sortWordGroups: Bool = false) -> [Photo] {
        var entities = [Photo]()
        forEach {
            let entity = $0.toDomain()
            entities.append(entity)
        }
        return entities
    }
}
