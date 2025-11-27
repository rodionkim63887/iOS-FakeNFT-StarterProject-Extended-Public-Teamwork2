import SwiftUI

@Observable
final class CartViewModel {
    var nfts: [NftMock] = [MockData.nftMock2, MockData.nftMock1, MockData.nftMock3]
    var deletingAttempt = false
    var blur: CGFloat = 0
    var nftToDelete: NftMock?
    
    var nftToDeleteImage: String {
       nftToDelete?.image ?? ""
    }
    
    func getTotalPrice() -> String {
        return String(format: "%.2f", nfts.reduce(0) { $0 + $1.price })
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
            assertionFailure("[CartViewModel] - deleteFromCart: No such NFT found.")
            return
        }
        
        withAnimation(.easeInOut) {
            nfts.removeAll(where: { $0.id == nftToDelete.id })
            deletingAttempt = false
            blur = 0
            self.nftToDelete = nil
        }
    }
    
    func sortByPrice() {
        nfts.sort(by: { $0.price < $1.price })
    }
    
    func sortByRating() {
        nfts.sort(by: { $0.rating > $1.rating })
    }
    
    func sortByName() {
        nfts.sort(by: { $0.name < $1.name })
    }
}
