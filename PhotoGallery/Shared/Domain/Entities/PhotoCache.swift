import SwiftUI

struct PhotoCache {
    let id: String
    let url: String
    let image: Image
    
    init(url: String, image: Image) {
        self.id = url
        self.url = url
        self.image = image
    }
}

extension PhotoCache: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
