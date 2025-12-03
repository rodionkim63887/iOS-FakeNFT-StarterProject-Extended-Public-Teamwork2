import SwiftUI

@Observable
final class CartStore {
    var items: [Nft] = [Nft(id: "7773e33c-ec15-4230-a102-92426a3a6d5a",
                            name: "Rosario Dejesus",
                            description: "explicari lobortis rutrum evertitur fugit convenire ligula",
                            author: "https://unruffled_cohen.fakenfts.org/",
                            price: 28.27,
                            imagesUrlsString: [
                                "https://code.s3.yandex.net/Mobile/iOS/NFT/Beige/Finn/1.png",
                                "https://code.s3.yandex.net/Mobile/iOS/NFT/Beige/Finn/2.png",
                                "https://code.s3.yandex.net/Mobile/iOS/NFT/Beige/Finn/3.png"
                            ],
                            rating: 3,
                            createdAt: "2023-10-08T07:43:22.944Z[GMT]"),
                        
                        Nft(id: "cc74e9ab-2189-465f-a1a6-8405e07e9fe4",
                            name: "James Burt",
                            description: "eos habeo percipit duis malesuada",
                            author: "https://exciting_pare.fakenfts.org/",
                            price: 11.14,
                            imagesUrlsString: [
                                "https://code.s3.yandex.net/Mobile/iOS/NFT/Blue/Clover/1.png",
                                "https://code.s3.yandex.net/Mobile/iOS/NFT/Blue/Clover/2.png",
                                "https://code.s3.yandex.net/Mobile/iOS/NFT/Blue/Clover/3.png"
                            ],
                            rating: 2,
                            createdAt: "2023-07-11T05:27:40.359Z[GMT]")]
    
    var deletingAttempt = false
    var blur: CGFloat = 0
    var nftToDelete: Nft?
    
    var nftToDeleteImage: URL? {
        guard let urlString = nftToDelete?.imagesUrlsString[0],
              let url = URL(string: urlString) else {
            return nil
        }
        
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
        if items.first(where: { $0.id == nft.id }) == nil {
            items.append(nft)
        }
    }

    func remove(_ nft: Nft) {
        items.removeAll { $0.id == nft.id }
    }
}
