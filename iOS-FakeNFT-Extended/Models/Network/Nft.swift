import Foundation

struct Nft: Decodable, Identifiable {
    let id: String
    let name: String
    let description: String
    let author: String
    let price: Float
    let imagesUrlsString: [String]
    let rating: Int
    let createdAt: String
}
