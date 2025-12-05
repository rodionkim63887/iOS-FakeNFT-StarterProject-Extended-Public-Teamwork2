import SwiftUI

@MainActor
public final class NftCatalogAssembly {
    
    private let services: ServicesAssembly
    
    init(services: ServicesAssembly) {
        self.services = services
    }
    
    public func build() -> some View {
        let viewModel = NftCatalogViewModel(
            service: services.collectionsService
            )
        return NftCatalogView(viewModel: viewModel)
    }
}
