@testable import PhotoGallery

extension Photo {
    static func getMockPhotos() -> [Photo] {
        [Photo(id: "1",
               photoDescription: "an aerial view of a desert with rocks and sand",
               urls: PhotoURLs(raw: "https://s3.us-west-2.amazonaws.com/images.unsplash.com/small/photo-1682687219573-3fd75f982217",
                               full: "https://s3.us-west-2.amazonaws.com/images.unsplash.com/small/photo-1682687219573-3fd75f982217",
                               small: "https://s3.us-west-2.amazonaws.com/images.unsplash.com/small/photo-1682687219573-3fd75f982217",
                               thumb: "https://s3.us-west-2.amazonaws.com/images.unsplash.com/small/photo-1682687219573-3fd75f982217",
                               small_s3: "https://s3.us-west-2.amazonaws.com/images.unsplash.com/small/photo-1682687219573-3fd75f982217"))]
    }
}
