import Foundation

struct Currency: Decodable, Hashable {
    let title: String
    let name: String
    let image: String
    let id: String
}
