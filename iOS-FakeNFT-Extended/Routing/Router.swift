import SwiftUI

@MainActor
@Observable
final class Router {
    enum Route: Hashable {
        case paymentMethod(currencies: [Currency])
        case successfulPayment
    }
    
    var path = NavigationPath()
    
    @ViewBuilder
    func view(for route: Route) -> some View {
        switch route {
        case .paymentMethod(let currencies):
            PaymentMethodView(currencies: currencies)
        case .successfulPayment:
            SuccessfulPaymentView()
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
