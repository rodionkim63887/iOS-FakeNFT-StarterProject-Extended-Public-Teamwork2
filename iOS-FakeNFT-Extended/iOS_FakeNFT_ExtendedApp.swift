import SwiftUI

@main
struct iOS_FakeNFT_ExtendedApp: App {
    @State private var cart = CartStore()
    
    let services = ServicesAssembly(
        networkClient: DefaultNetworkClient(),
        nftStorage: NftStorageImpl()
    )
    
    var body: some Scene {
        WindowGroup {
            RouterView {
                ContentView()
            }
            .environment(services)
            .environment(cart)
        }
    }
}
