import Foundation

@Observable
@MainActor
final class AppStartViewModel {
    var isReady = false
    var isError = false

    private let services: ServicesAssembly
    private let profileStore: UserProfileStore

    init(services: ServicesAssembly, profileStore: UserProfileStore) {
        self.services = services
        self.profileStore = profileStore
    }

    func start() async {
        do {
            let profile = try await services.userProfileService.loadUserProfile()
            profileStore.update(with: profile)
            isReady = true
        } catch {
            isError = true
        }
    }
    
    func retry() async {
        await start()
    }
}
