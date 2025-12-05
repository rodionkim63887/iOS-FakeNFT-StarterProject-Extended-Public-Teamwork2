import Foundation
import Observation

@Observable
@MainActor
final class NftCollectionViewModel {
    
    private let service: NftService
    private let collection: NftCollection
    
    var nfts: [Nft] = []
    var isLoading: Bool = false
    
    init(
        service: NftService,
        collection: NftCollection
    ) {
        self.service = service
        self.collection = collection
    }
    
    func loadNfts() async {
        isLoading = true
        defer { isLoading = false }
        
        var loaded: [Nft] = []
                
        for id in collection.nfts {
            if let nft = try? await service.loadNft(id: id) {
                loaded.append(nft)
            }
        }
        
        nfts = loaded
    }
    
    func toggleLike(for id: String) {} // TODO: in sprint_03
    
    func toggleInCart(fot id: String) {} // TODO: in sprint_03
}
