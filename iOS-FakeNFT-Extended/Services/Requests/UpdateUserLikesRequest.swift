import Foundation

struct UpdateUserLikesRequest: NetworkRequest {
    
    let dto: Encodable?

    init(likedIds: [String]) {
        self.dto = StringArrayDTO(strings: likedIds)
    }
    
    var httpMethod: HttpMethod {
        .put
    }
    
    var endpoint: URL? {
        URL(string: "\(RequestConstants.baseURL)/api/v1/profile/1")
    }
}
