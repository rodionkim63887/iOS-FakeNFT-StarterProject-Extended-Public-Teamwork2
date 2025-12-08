import SwiftUI

struct CartToggleButton: View {
    @Environment(CartStore.self) private var cart
    
    let nft: Nft
    let size: CGFloat
    
    init(nft: Nft, size: CGFloat = 16) {
        self.nft = nft
        self.size = size
    }
    
    var body: some View {
        Button {
            toggle()
        } label: {
            Image(iconName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: size)
                .foregroundStyle(Color(.blackUniversal))
        }
    }
    
    private var iconName: String {
        cart.items.contains(where: { $0.id == nft.id })
        ? "DeleteFromCart"
        : "AddToCart"
    }
    
    private func toggle() {
        if cart.items.contains(where: { $0.id == nft.id }) {
            cart.remove(nft)
        } else {
            cart.add(nft)
        }
    }
}
