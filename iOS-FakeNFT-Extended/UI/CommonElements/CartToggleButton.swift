import SwiftUI

struct CartToggleButton: View {
    let isInCart: Bool
    let size: CGFloat
    let onToggle: () -> Void
    
    init(isInCart: Bool, size: CGFloat = 16, onToggle: @escaping () -> Void) {
        self.isInCart = isInCart
        self.size = size
        self.onToggle = onToggle
    }
    
    var body: some View {
        Button(action: onToggle) {
            Image(isInCart ? "DeleteFromCart" : "AddToCart")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: size)
                .foregroundStyle(Color(.blackUniversal))
        }
    }
}
