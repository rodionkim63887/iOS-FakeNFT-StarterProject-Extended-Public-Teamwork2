import Foundation

struct SetCurrencyRequest: NetworkRequest {
    let currency: String
    
    init(currency: String) {
        self.currency = currency
    }
    
    var endpoint: URL? {
        URL(string: "\(RequestConstants.baseURL)/api/v1/orders/1/payment/\(currency)")
    }
}
