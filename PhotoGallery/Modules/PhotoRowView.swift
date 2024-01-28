import SwiftUI

//struct PhotoRowView: View {
//    let photo: PhotoData
//    @Environment(PhotoGalleryListViewModel.self) private var viewModel
//    
//    init(photod: Binding<PhotoData>) {
//    }
//
//    var body: some View {
//        HStack {
//            if photo.photoState == .downloaded, let photoImage = photo.photoCache?.image {
//                photoImage
//                    .resizable()
//                    .frame(width: 150, height: 150)
//            } else {
//                Button {
//                    viewModel.downloadImage(photo: photo)
//                } label: {
//                    Image(systemName: "arrow.down.circle.dotted")
//                        .resizable()
//                        .frame(width: 50, height: 50)
//                }
//                
//            }
//            Text(photo.photo.photoDescription ?? "No description")
//        }
//    }
//}
