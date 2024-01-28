import SwiftUI

struct PhotoGalleryListView: View {
    @State var viewModel = PhotoGalleryListViewModel()
    
    init(photosDIContainer: PhotosDIContainer) {
        self.viewModel.setDIContainer(photosDIContainer)
    }
    
    var body: some View {
        List {
            Section {
                ForEach(viewModel.photos) { photo in
                    HStack {
                        if photo.photoState == .downloaded, let photoImage = photo.photoCache?.image {
                            photoImage
                                .resizable()
                                .frame(width: 150, height: 150)
                        } else {
                            Button {
                                viewModel.downloadImage(photo: photo)
                            } label: {
                                Image(systemName: "arrow.down.circle.dotted")
                                    .resizable()
                                    .frame(width: 50, height: 50)
                            }
                            
                        }
                        Text(photo.photo.photoDescription ?? "No description")
                    }
                }
            }
            if viewModel.hasMorePages {
                HStack {
                    Spacer()
                    Button("Load More") {
                        viewModel.loadNextPage()
                    }
                    .buttonStyle(.borderedProminent)
                    Spacer()
                }
            }
        }
        .listStyle(.plain)
        .onAppear {
            viewModel.loadNextPage()
        }
    }
}

#Preview {
    PhotoGalleryListView(photosDIContainer: DefaultPhotosDIContainer())
}
