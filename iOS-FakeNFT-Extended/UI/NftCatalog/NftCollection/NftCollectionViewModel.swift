import Foundation
import Observation

@Observable
@MainActor
final class NftCollectionViewModel {
    
    private let nftIds: [String]
    private var service: NftService
    
    var nfts: [Nft] = []
    var isLoading: Bool = false
    
    init(
        service: NftService,
        nftIds: [String]
    ) {
        self.service = service
        self.nftIds = nftIds
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
                print("Failed to load NFT:", id, "error:", error)
            }
        }
        
        nfts = loaded
        
        print(nfts)
    }
    
    func toggleLike(for id: String) {} // TODO: in sprint_03
    
    func toggleInCart(fot id: String) {} // TODO: in sprint_03
}
