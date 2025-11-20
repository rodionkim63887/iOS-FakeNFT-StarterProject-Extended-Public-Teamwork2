import Foundation

struct GetNftByIdRequest: NetworkRequest {

    let nft_id: String

    var endpoint: URL? {
        URL(string: "\(RequestConstants.baseURL)/api/v1/nft/\(nft_id)")
    }
}
