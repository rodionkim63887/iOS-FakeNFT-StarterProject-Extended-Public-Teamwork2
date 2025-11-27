import Foundation

struct UserProfile: Decodable {
    let name: String
    let avatar: String
    let description: String?
    let website: String?
    let ntfs: [String]
    let likes: [String]
    let id: String
}
