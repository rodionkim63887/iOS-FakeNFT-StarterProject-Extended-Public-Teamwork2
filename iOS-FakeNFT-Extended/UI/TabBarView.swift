import SwiftUI

struct TabBarView: View {
    
    @Environment(ServicesAssembly.self) private var assembly

    var body: some View {
        TabView {
            NftCatalogAssembly(services: assembly).build()
                .tabItem {
                    Label(
                        NSLocalizedString("Tab.catalog", comment: ""),
                        systemImage: "square.stack.3d.up.fill"
                    )
                }
                .backgroundStyle(.background)
            
            CartView()
                .tabItem {
                    Label(
                        NSLocalizedString("Tab.cart", comment: ""),
                        image: "TabBarCart"
                    )
                    .foregroundStyle(Color.accentColor)
                }
        }
    }
}
