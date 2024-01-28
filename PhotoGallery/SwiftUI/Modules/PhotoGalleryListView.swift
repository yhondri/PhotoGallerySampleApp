import SwiftUI

struct PhotoGalleryListView: View {
    @State var viewModel = PhotoGalleryListViewModel()
    
    init(photosDIContainer: PhotosDIContainer) {
        self.viewModel.setDIContainer(photosDIContainer)
    }
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    ForEach(viewModel.photos) { photo in
                        buildPhotoRowView(photo: photo)
                    }
                }
                if viewModel.hasMorePages {
                    buildLoadMoreRowView()
                }
            }
            .listStyle(.plain)
            .navigationTitle("Photo Gallery List")
        }
        .accessibility(identifier: "PhotoGalleryListview")
        .environment(viewModel)
        .onAppear {
            viewModel.loadNextPage()
        }
    }
    
    @ViewBuilder
    private func buildPhotoRowView(photo: PhotoData) -> some View {
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
        .accessibility(identifier: "PhotoRowView")
        .onAppear {
            viewModel.downloadImage(photo: photo)
        }
    }
    
    @ViewBuilder
    private func buildLoadMoreRowView() -> some View {
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

#Preview {
    PhotoGalleryListView(photosDIContainer: DefaultPhotosDIContainer())
}
