import SwiftUI
import Observation

@Observable
@MainActor
final class NftCollectionViewModel {
    
    private let service: NftService
    private let likesManager: UserLikesManager
    private let userStore: UserProfileStore
    private let cartStore: CartStore
    
    let nftIds: [String]
    var nfts: [Nft] = []
    var isLoading: Bool = false
    var errorMessage: String? = nil
    
    init(service: NftService,
         nftIds: [String],
         likesManager: UserLikesManager,
         userStore: UserProfileStore,
         cartStore: CartStore
    ) {
        self.service = service
        self.nftIds = nftIds
        self.likesManager = likesManager
        self.userStore = userStore
        self.cartStore = cartStore
    }
    
    func loadNfts() async {
        isLoading = true
        defer { isLoading = false }
        
        var loaded: [Nft] = []
        
        for id in nftIds {
            do {
                let nft = try await service.loadNft(id: id)
                loaded.append(nft)
            } catch {
                errorMessage = error.localizedDescription
                nfts = []
            }
        }
        
        nfts = loaded
    }
    
    func retry() async {
        await loadNfts()
    }
    
    func toggleLike(for id: String) {
        likesManager.toggleLike(id: id)
    }
    
    func toggleCart(_ nft: Nft) {
        if isInCart(nft) { cartStore.remove(nft) }
        else { cartStore.add(nft) }
    }
    
    func isLiked(_ id: String) -> Bool {
        userStore.likedIds.contains(id)
    }
    
    func isInCart(_ nft: Nft) -> Bool {
        cartStore.items.contains(where: { $0.id == nft.id })
    }

}
