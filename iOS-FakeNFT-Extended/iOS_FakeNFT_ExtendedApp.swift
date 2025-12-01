import SwiftUI

@main
struct iOS_FakeNFT_ExtendedApp: App {
    @State private var cart = CartStore()
    
    var body: some Scene {
        WindowGroup {
            RouterView {
                ContentView()
                    .environment(ServicesAssembly(networkClient: DefaultNetworkClient(), nftStorage: NftStorageImpl()))
                    .environment(cart)
            }
        }
    }
}
