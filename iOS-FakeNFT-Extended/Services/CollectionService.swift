import Foundation

protocol CollectionService {
    func loadCollections(
        page: Int,
        size: Int,
        sortBy: String?
    ) async throws -> [NftCollection]
}

@MainActor
final class CollectionServiceImpl: CollectionService {
    
    private let networkClient: NetworkClient
    
    init(networkClient: NetworkClient) {
        self.networkClient = networkClient
    }
    
    func loadCollections(
        page: Int,
        size: Int,
        sortBy: String?
    ) async throws -> [NftCollection] {
        
        let request = GetNftCollecionRequest(page: page, size: size, soryBy: sortBy)
        return try await networkClient.send(request: request)
    }
}
