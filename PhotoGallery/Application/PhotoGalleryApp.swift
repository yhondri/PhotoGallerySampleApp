//
//  PhotoGalleryApp.swift
//  PhotoGallery
//
//  Created by Yhondri Acosta Novas on 27/1/24.
//

import SwiftUI

@main
struct PhotoGalleryApp: App {
    private let defaultPhotosDIContainer = DefaultPhotosDIContainer()
    
    var body: some Scene {
        WindowGroup {
            PhotoGalleryListView(photosDIContainer: defaultPhotosDIContainer)
        }
    }
}
