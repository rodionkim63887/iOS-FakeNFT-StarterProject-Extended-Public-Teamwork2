import Foundation

protocol CollectionService {
    func loadCollections() async throws -> [NftCollection]
}

@MainActor
final class CollectionServiceImpl: CollectionService {
    
    private let networkClient: NetworkClient
    
    init(networkClient: NetworkClient) {
        self.networkClient = networkClient
    }
    
    func loadCollections() async throws -> [NftCollection] {
        
        let request = GetNftCollecionRequest(page: 0, size: 10, sortBy: nil)
        return try await networkClient.send(request: request)
    }
}
