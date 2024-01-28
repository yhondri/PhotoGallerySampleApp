import SwiftUI

struct PhotoGalleryUIKitView: UIViewControllerRepresentable {
    typealias UIViewControllerType = PhotoGalleryViewController
    
    private let photosDIContainer: PhotosDIContainer
    
    init(photosDIContainer: PhotosDIContainer) {
        self.photosDIContainer = photosDIContainer
    }

    func makeUIViewController(context: Context) -> PhotoGalleryViewController {
        PhotoGalleryViewController(photosDIContainer: photosDIContainer)
    }
    
    func updateUIViewController(_ uiViewController: PhotoGalleryViewController, context: Context) { }
}
