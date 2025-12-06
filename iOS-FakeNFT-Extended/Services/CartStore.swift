import SwiftUI

@Observable
final class CartStore {
    var items: [Nft] = []
    
    var deletingAttempt = false
    var blur: CGFloat = 0
    var nftToDelete: Nft?
    
    var nftToDeleteImage: URL? {
        guard let urlString = nftToDelete?.imagesUrlsString.first,
              let url = URL(string: urlString) else { return nil }
        return url
    }
    
    var totalPrice: Float {
        items.reduce(0) { $0 + $1.price }
    }
    
    func tryDeletingFromCart(nft: Nft) {
        withAnimation(.easeInOut) {
            deletingAttempt = true
            blur = 10
            nftToDelete = nft
        }
    }
    
    func cancelDeleting() {
        withAnimation(.easeInOut) {
            deletingAttempt = false
            blur = 0
            nftToDelete = nil
        }
    }
    
    func deleteFromCart() {
        withAnimation(.easeInOut) {
            deletingAttempt = false
            blur = 0
            nftToDelete = nil
        }
    }

    func add(_ nft: Nft) {
        if !items.contains(where: { $0.id == nft.id }) {
            items.append(nft)
        }
    }

    func remove(_ nft: Nft) {
        items.removeAll { $0.id == nft.id }
    }
}
