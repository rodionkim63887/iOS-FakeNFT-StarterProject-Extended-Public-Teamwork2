import Foundation

struct SetCurrencyRequest: NetworkRequest {
    let currency: String
    
    var endpoint: URL? {
        URL(string: "\(RequestConstants.baseURL)/api/v1/orders/1/payment/\(currency)")
    }
}
