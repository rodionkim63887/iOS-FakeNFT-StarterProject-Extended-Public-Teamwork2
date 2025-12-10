import Foundation

protocol CollectionsService {
    func loadCollections() async throws -> [NftCollection]
}

@MainActor
final class CollectionsServiceImpl: CollectionsService {
    
    private let networkClient: NetworkClient
    
    init(networkClient: NetworkClient) {
        self.networkClient = networkClient
    }
    
    func loadCollections() async throws -> [NftCollection] {
        
        let request = GetNftCollectionsRequest(page: 0, size: 10, sortBy: nil)
                
        return try await networkClient.send(request: request)
    }
}
