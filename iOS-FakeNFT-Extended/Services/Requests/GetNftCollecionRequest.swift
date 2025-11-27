import Foundation

enum CollectionSortOptions {
    case byName
//    case byNftCount
    
    var sortParameter: String {
        switch self {
        case .byName:
            return "name,asc"
//        case .byNftCount:
//            return "
        }
    }
}

struct GetNftCollecionRequest: NetworkRequest {
    
    let page: Int?
    let size: Int?
    let soryBy: String?
    
    var endpoint: URL? {
        var components = URLComponents(string: "\(RequestConstants.baseURL)/api/v1/collections")
        
        var queryItems: [URLQueryItem] = []
        
        if let page = page {
            queryItems.append(URLQueryItem(name: "page", value: "\(page)"))
        }
        
        if let size = size {
            queryItems.append(URLQueryItem(name: "size", value: "\(size)"))
        }
        
        if let soryBy = soryBy {
            queryItems.append(URLQueryItem(name: "soryBy", value: soryBy))
        }
        
        components?.queryItems = queryItems
        
        return components?.url
    }
}
