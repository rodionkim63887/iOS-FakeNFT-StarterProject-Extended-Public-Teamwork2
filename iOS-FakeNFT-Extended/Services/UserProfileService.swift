import Foundation

protocol UserProfileService {
    func loadUserProfile() async throws -> UserProfile
    
    func updateUserLikes(_ ids: [String]) async throws -> UserProfile
}

@MainActor
final class UserProfileServiceImpl: UserProfileService {
    
    private let networkClient: NetworkClient
    
    init(networkClient: NetworkClient) {
        self.networkClient = networkClient
    }
    
    func loadUserProfile() async throws -> UserProfile {
        let request = GetUserProfileRequest()
        return try await networkClient.send(request: request)
    }
    
    func updateUserLikes(_ ids: [String]) async throws -> UserProfile {
        let request = UpdateUserLikesRequest(likedIds: ids)
        return try await networkClient.send(request: request)
    }
}
