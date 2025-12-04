import SwiftUI

@MainActor
@Observable
final class Router {
    enum Route: Hashable {
        case nftDetailBridge
    }
    
    var path = NavigationPath()
    
    @ViewBuilder
    func view(for route: Route) -> some View {
        switch route {
        case .nftDetailBridge:              //Тестовый кейс. Можно убрать, как только добавите хотя бы один свой.
            NftDetailBridgeView()
        }
    }
    
    func push(_ appRoute: Route) {
        path.append(appRoute)
    }
    
    func pop() {
        guard !path.isEmpty else { return }
        path.removeLast()
    }
    
    func popToRoot() {
        path.removeLast(path.count)
    }
}
