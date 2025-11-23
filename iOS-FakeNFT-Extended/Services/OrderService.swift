import Foundation

protocol OrderService {
    func loadOrder() async throws -> Order
    func updateCart(with nfts: [String]) async throws -> Order
}

@MainActor
final class OrderServiceImpl: OrderService {
    
    private let networkClient: NetworkClient
    
    init(networkClient: NetworkClient) {
        self.networkClient = networkClient
    }
    
    func loadOrder() async throws -> Order {
        let request = GetOrderRequest()
        return try await networkClient.send(request: request)
    }
    
    func updateCart(with nfts: [String]) async throws -> Order {
        let request = UpdateCartRequest(addedNfts: nfts)
        return try await networkClient.send(request: request)
    }
}
