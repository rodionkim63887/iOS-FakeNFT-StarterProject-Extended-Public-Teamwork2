import SwiftUI

struct RouterView<Content: View>: View {
    @State private var router = Router()
    private let content: Content
    
    init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content()
    }

    var body: some View {
        NavigationStack(path: $router.path) {
            content
                .navigationDestination(for: Router.Route.self) {
                    router.view(for: $0)
                        .navigationBarBackButtonHidden()
                }
        }
        .environment(router)
    }
}
