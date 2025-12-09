import Foundation

@Observable
@MainActor
final class UserProfileStore {
    var likedIds: Set<String> = []
    var name: String = ""

    func update(with profile: UserProfile) {
        likedIds = Set(profile.likes)
        name = profile.name
    }
}
