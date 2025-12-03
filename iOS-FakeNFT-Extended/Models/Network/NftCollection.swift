import Foundation

struct NftCollection: Decodable, Identifiable {
    let id: String
    let name: String
    let cover: String
    let description: String
    let author: String
    let createdAt: Date
    let nfts: [String]
}
