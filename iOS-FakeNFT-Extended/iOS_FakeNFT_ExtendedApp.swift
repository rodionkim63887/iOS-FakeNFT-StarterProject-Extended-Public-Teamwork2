import SwiftUI

@main
struct iOS_FakeNFT_ExtendedApp: App {
    @State private var cartStore = CartStore()
    @State private var userProfileStore = UserProfileStore()
    @State private var likesManager: UserLikesManager
    
    @State private var startVM: AppStartViewModel
    
    private let services = ServicesAssembly(
        networkClient: DefaultNetworkClient(),
        nftStorage: NftStorageImpl()
    )
    
    init() {
        let userProfileStore = UserProfileStore()
        
        let services = ServicesAssembly(
            networkClient: DefaultNetworkClient(),
            nftStorage: NftStorageImpl()
        )
        
        let likesManager = UserLikesManager(
            store: userProfileStore,
            service: services.userProfileService
        )
        
        _userProfileStore = State(initialValue: userProfileStore)
        _likesManager = State(initialValue: likesManager)
        _startVM = State(initialValue: AppStartViewModel(
            services: services,
            profileStore: userProfileStore,
            likesManager: likesManager
        ))
    }
    
    var body: some Scene {
        WindowGroup {
            if startVM.isReady {
                RouterView {
                    ContentView()
                }
                .environment(services)
                .environment(cartStore)
                .environment(userProfileStore)
                .environment(likesManager)
            } else {
                SplashScreenView()
                    .environment(startVM)
                    .environment(likesManager)
            }
        }
    }
}
