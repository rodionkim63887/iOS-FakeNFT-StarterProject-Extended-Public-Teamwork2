final class MockUserProfileService: UserProfileService {
    func loadUserProfile() async throws -> UserProfile {
        UserProfile(
            name: "Preview User",
            avatar: "",
            description: nil,
            website: nil,
            nfts: [],
            likes: ["2", "4"],
            id: "preview-user"
        )
    }
    
    func updateUserLikes(_ ids: [String]) async throws -> UserProfile {
        UserProfile(
            name: "Preview User",
            avatar: "",
            description: nil,
            website: nil,
            nfts: [],
            likes: ids,
            id: "preview-user"
        )
    }
}
