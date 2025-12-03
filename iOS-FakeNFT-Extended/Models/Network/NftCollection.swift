import Foundation

struct NftCollection: Decodable, Identifiable {
    let id: String
    let name: String
    let cover: URL
    let description: String
    let author: String
    let createdAt: Date
    let nfts: [String]
}
