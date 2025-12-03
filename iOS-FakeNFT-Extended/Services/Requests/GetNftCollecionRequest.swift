import Foundation

struct GetNftCollecionRequest: NetworkRequest {
    
    let page: Int?
    let size: Int?
    let sortBy: String?
    
    var endpoint: URL? {
        var components = URLComponents(string: "\(RequestConstants.baseURL)/api/v1/collections")
        
        var queryItems: [URLQueryItem] = []
        
        if let page = page {
            queryItems.append(URLQueryItem(name: "page", value: "\(page)"))
        }
        
        if let size = size {
            queryItems.append(URLQueryItem(name: "size", value: "\(size)"))
        }
        
        if let sortBy = sortBy {
            queryItems.append(URLQueryItem(name: "soryBy", value: "\(sortBy)"))
        }
        
        components?.queryItems = queryItems
        
        return components?.url
    }
}
