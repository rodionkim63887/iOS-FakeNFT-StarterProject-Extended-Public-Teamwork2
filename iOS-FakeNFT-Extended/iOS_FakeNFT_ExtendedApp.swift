import SwiftUI

@main
struct iOS_FakeNFT_ExtendedApp: App {
    @State private var cartStore = CartStore()
    @State private var userProfileStore = UserProfileStore()
    
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
        _userProfileStore = State(initialValue: userProfileStore)
        _startVM = State(initialValue: AppStartViewModel(
            services: services,
            profileStore: userProfileStore
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
            } else {
                SplashScreenView()
                    .environment(startVM)
            }
        }
    }
}
