import Foundation

struct UpdateUserLikesRequest: NetworkRequest {
    
    let likedIds: [String]

    var httpMethod: HttpMethod { .put }

    var endpoint: URL? {
        URL(string: "\(RequestConstants.baseURL)/api/v1/profile/1")
    }

    var headers: [String : String]? {
        ["Content-Type": "application/x-www-form-urlencoded"]
    }

    var body: Data? {
        if likedIds.isEmpty {
            return "likes=".data(using: .utf8)
        } else {
            let str = likedIds.map { "likes=\($0)" }.joined(separator: "&")
            return str.data(using: .utf8)
        }
    }
}
