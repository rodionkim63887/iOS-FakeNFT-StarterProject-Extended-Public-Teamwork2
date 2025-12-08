import Foundation

@Observable
@MainActor
final class AppStartViewModel {
    var isReady = false
    var isError = false

    private let services: ServicesAssembly
    private let profileStore: UserProfileStore
    private let likesManager: UserLikesManager

    init(
        services: ServicesAssembly,
        profileStore: UserProfileStore,
        likesManager: UserLikesManager
    ) {
        self.services = services
        self.profileStore = profileStore
        self.likesManager = likesManager
    }

    func start() async {
        do {
            let profile = try await services.userProfileService.loadUserProfile()
            profileStore.update(with: profile)
            likesManager.initialize(from: profile)
            isReady = true
        } catch {
            isError = true
        }
    }
    
    func retry() async {
        await start()
    }
}
