import Foundation

struct Nft: Decodable, Identifiable {
    let id: String
    let name: String
    let description: String
    let author: String
    let price: Float
    let images: [String]
    let rating: Int
    let createdAt: String
}
