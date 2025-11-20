import Foundation

struct Nft: Decodable, Identifiable {
    let id: String
    let name: String
    let description: String
    let author: String
    let price: Double
    let images: [URL]
    let rating: Int
    let createdAt: Date
}
