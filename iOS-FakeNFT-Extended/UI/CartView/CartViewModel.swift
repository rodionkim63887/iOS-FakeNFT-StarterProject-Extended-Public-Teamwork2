import SwiftUI

@Observable
final class CartViewModel {
    var nfts: [NftMock] = [NftMock.nftMock1, NftMock.nftMock2, NftMock.nftMock3]
    var deletingAttempt = false
    var blur: CGFloat = 0
    var nftToDelete: NftMock?
    
    func tryDeletingFromCart(nft: NftMock) {
        deletingAttempt = true
        blur = 10
        nftToDelete = nft
    }
    
    func cancelDeleting() {
        deletingAttempt = false
        blur = 0
        nftToDelete = nil
    }
    
    func deleteFromCart() {
        guard let nftToDelete else {
            return
        }
        
        nfts.removeAll(where: { $0.id == nftToDelete.id })
        deletingAttempt = false
        blur = 0
    }
}
