import SwiftUI

struct NftCollectionDetailScreen: View {
    @Environment(ServicesAssembly.self) private var services
    
    let collection: NftCollectionViewData
    
    var body: some View {
        let viewModel = NftCollectionViewModel(
            service: services.nftService,
            nftIds: collection.nftIds
        )
        
        NftCollectionDetailView(
            collection: collection,
            viewModel: viewModel
        )
    }
}
