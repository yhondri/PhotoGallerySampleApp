@testable import PhotoGallery

extension PhotosResponseDTO {
    static let photo = PhotosResponseDTO(id: "1",
                                         photoDescription: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua",
                                         urls: photoURLsDTO)
    static let photoURLs = "https://images.unsplash.com/photo-1682687220945-922198770e60?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w1NTkwOTZ8MXwxfGFsbHwxMXx8fHx8fDJ8fDE3MDY0NDE4MzJ8&ixlib=rb-4.0.3&q=80&w=200"
    static let photoURLsDTO = PhotoURLsDTO(raw: photoURLs,
                                           full: photoURLs,
                                           small: photoURLs,
                                           thumb: photoURLs,
                                           small_s3: photoURLs)
}
