import SwiftUI

@MainActor
@Observable
final class UserLikesManager {
    private let store: UserProfileStore
    private let service: UserProfileService
    
    private var pendingLikes: Set<String> = []
    private var isUpdating = false
    
    init(store: UserProfileStore, service: UserProfileService) {
        self.store = store
        self.service = service
    }
    
    func initialize(from profile: UserProfile) {
        store.likedIds = Set(profile.likes)
        pendingLikes = store.likedIds
    }
    
    func toggleLike(id: String) {
        if store.likedIds.contains(id) {
            store.likedIds.remove(id)
        } else {
            store.likedIds.insert(id)
        }
        
        pendingLikes = store.likedIds
        
        if !isUpdating {
            Task { await sendUpdate() }
        }
    }
    
    private func sendUpdate() async {
        isUpdating = true
        
        let likesToSend = pendingLikes
        do {
            let updated = try await service.updateUserLikes(Array(likesToSend))
            store.likedIds = Set(updated.likes)
            pendingLikes = store.likedIds
            
            if pendingLikes != likesToSend {
                await sendUpdate()
            }
        } catch {
            print("failed to update likes: \(error)")
        }
        
        isUpdating = false
    }
}
