import SwiftUI


struct NftDetailBridgeView: UIViewControllerRepresentable {
    typealias UIViewControllerType = NftDetailViewController
    
    let id: String
    @Environment(ServicesAssembly.self) var servicesAssembly

    func makeUIViewController(context: Context) -> NftDetailViewController {
        let assembly = NftDetailAssembly(servicesAssembler: servicesAssembly)
        let input = NftDetailInput(id: id)

        // Если сборка требует presenter:
        // let controller = assembly.build(with: input, presenter: nil)

        let controller = assembly.build(with: input)

        guard let detailVC = controller as? NftDetailViewController else {
            fatalError("""
            ❌ NftDetailAssembly.build returned wrong VC type.
            Expected: NftDetailViewController
            Got: \(type(of: controller))
            """)
        }

        return detailVC
    }

    func updateUIViewController(_ uiViewController: NftDetailViewController, context: Context) {
        // обновления, если нужно
    }
}

private enum Constants {
    static let testNftId = "7773e33c-ec15-4230-a102-92426a3a6d5a"
}
