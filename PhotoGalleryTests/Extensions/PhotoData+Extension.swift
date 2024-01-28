//
//  PhotoData+Extension.swift
//  PhotoGalleryTests
//
//  Created by Yhondri Acosta Novas on 28/1/24.
//

@testable import PhotoGallery

extension PhotoData {
    static let photoData = PhotoData(id: "1",
                                     photo: Photo.getMockPhotos().first!,
                                     photoCache: nil,
                                     photoState: .missing)
}
