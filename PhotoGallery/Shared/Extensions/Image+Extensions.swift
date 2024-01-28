//
//  Image+Extensions.swift
//  PhotoGallery
//
//  Created by Yhondri Acosta Novas on 28/1/24.
//

import SwiftUI
import UIKit

extension Image {
    @MainActor func renderToUIImage() -> UIImage? {
        return ImageRenderer(content: self).uiImage
    }
}
