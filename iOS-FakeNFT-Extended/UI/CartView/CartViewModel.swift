import SwiftUI

@Observable
final class CartViewModel {
    var deletingAttempt = false
    var blur: CGFloat = 0
    var nftToDelete: Nft?
    
    var nftToDeleteImage: String {
       nftToDelete?.images[0] ?? ""
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
            self.nftToDelete = nil
        }
    }
}
