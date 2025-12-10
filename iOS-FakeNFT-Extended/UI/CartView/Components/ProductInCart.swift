import SwiftUI
import Kingfisher

struct ProductInCart: View {
    @Environment(CartStore.self) private var cart
    
    let nft: Nft
    
    var body: some View {
        ZStack {
            Color.primaryColor
                .ignoresSafeArea()
            
            HStack(spacing: 20) {
                KFImage(URL(string: nft.images[0]))
                    .resizable()
                    .scaledToFit()
                    .clipShape(
                        RoundedRectangle(cornerRadius: 12)
                    )
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(nft.name)
                        .font(.bold17)
                        .foregroundStyle(Color.accentColor)
                        .lineLimit(1)
                    
                    NftRatingView(rating: Int(nft.rating))
                    
                    Spacer()
                    
                    Text("Цена")
                        .font(.regular13)
                        .foregroundStyle(Color.accentColor)
                    
                    Text("\(String(format: "%.2f", nft.price)) ETH")
                        .font(.bold17)
                        .foregroundStyle(Color.accentColor)
                }
                .padding(.vertical, 8)
                
                Spacer()
                
                CartToggleButton(
                    isInCart: cart.items.contains(where: { $0.id == nft.id }),
                    onToggle: { cart.tryDeletingFromCart(nft: nft) }
                )
            }
            .frame(height: 108)
        }
    }
}
