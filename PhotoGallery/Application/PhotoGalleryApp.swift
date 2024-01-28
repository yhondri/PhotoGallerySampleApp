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
            NavigationStack {
                NavigationLink("Show SwiftUI Sample") {
                    PhotoGalleryListView(photosDIContainer: defaultPhotosDIContainer)
                }
                .padding(.bottom)
                NavigationLink("Show UIKit Sample") {
                    PhotoGalleryUIKitView(photosDIContainer: defaultPhotosDIContainer)
                }
            }
        }
    }
}
