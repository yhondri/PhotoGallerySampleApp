import Foundation
import SwiftUI

protocol PhotosRepository {
    func fetchPhotos(page: Int) async throws -> Result<PhotoPage, Error>
    func fetchImage(imageUrlString: String) async throws -> PhotoCache?
}
