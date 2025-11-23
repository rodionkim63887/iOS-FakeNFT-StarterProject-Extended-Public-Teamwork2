import Foundation

struct UpdateCartRequest: NetworkRequest {
    
    let dto: Encodable?

    init(addedNfts: [String]) {
        self.dto = StringArrayDTO(strings: addedNfts)
    }
    
    var httpMethod: HttpMethod {
        .put
    }
    
    var endpoint: URL? {
        URL(string: "\(RequestConstants.baseURL)/api/v1/orders/1")
    }
}
