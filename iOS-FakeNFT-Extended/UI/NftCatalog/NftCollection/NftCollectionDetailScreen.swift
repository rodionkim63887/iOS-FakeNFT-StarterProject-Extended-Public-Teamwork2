import SwiftUI

struct NftCollectionDetailScreen: View {
    @Environment(ServicesAssembly.self) private var services
    @Environment(UserProfileStore.self) var userStore
    @Environment(CartStore.self) var cartStore
    @Environment(UserLikesManager.self) var likesManager
    
    let collection: NftCollectionViewData
    
    var body: some View {
        let viewModel = NftCollectionViewModel(
            service: services.nftService,
            nftIds: collection.nftIds,
            likesManager: likesManager,
            userStore: userStore,
            cartStore: cartStore
        )
        
        NftCollectionDetailView(
            collection: collection,
            viewModel: viewModel
        )
    }
}
