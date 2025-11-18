import SwiftUI

@Observable
final class CartViewModel {
    var nfts: [NftMock] = [NftMock.nftMock1, NftMock.nftMock2, NftMock.nftMock3]
    var deletingAttempt = false
    var blur: CGFloat = 0
    var nftToDelete: NftMock?
    
    func getTotalPrice() -> String {
        var totalPrice: Double = 0
        for nft in nfts {
            totalPrice += nft.price
        }
        
        return String(format: "%.2f", totalPrice)
    }
    
    func tryDeletingFromCart(nft: NftMock) {
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
        guard let nftToDelete else {
            return
        }
        
        withAnimation(.easeInOut) {
            nfts.removeAll(where: { $0.id == nftToDelete.id })
            deletingAttempt = false
            blur = 0
        }
    }
    
    func getImage() -> String {
        guard let nftToDelete else {
            return ""
        }
        
        return nftToDelete.image
    }
}
