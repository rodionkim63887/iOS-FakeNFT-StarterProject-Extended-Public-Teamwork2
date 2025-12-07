import Foundation
import Observation

@Observable
@MainActor
final class NftCollectionViewModel {
    
    private var service: NftService
    
    let nftIds: [String]
    var nfts: [Nft] = []
    var isLoading: Bool = false
    var errorMessage: String? = nil
    
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
                errorMessage = error.localizedDescription
                nfts = []
            }
        }
        
        nfts = loaded
    }
    
    func retry() async {
        await loadNfts()
    }
    
    func toggleLike(for id: String) {} // TODO: in sprint_03
}
