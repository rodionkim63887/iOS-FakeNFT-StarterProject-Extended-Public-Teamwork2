import Foundation

protocol OrderService {
    func loadOrder() async throws -> Order
    func updateCart(with nfts: [String]) async throws -> Order
    func getCurrencies() async throws -> [Currency]
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
    
    func getCurrencies() async throws -> [Currency] {
        let request = GetCurrenciesRequest()
        return try await networkClient.send(request: request)
    }
}
