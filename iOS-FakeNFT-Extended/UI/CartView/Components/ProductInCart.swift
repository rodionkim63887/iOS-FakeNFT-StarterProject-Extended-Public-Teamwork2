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
                KFImage(URL(string: nft.imagesUrlsString[0]))
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
//                        .layoutPriority(1)
                    
                    ratingScale
                    
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
                
                Button {
                    print("Delete")
                    cart.tryDeletingFromCart(nft: nft)
                } label: {
                    Image("DeleteFromCart")
                        .frame(width: 40, height: 40)
                        .foregroundStyle(Color.accentColor)
                }
                .buttonStyle(.plain)
            }
            .frame(height: 108)
                
        }
    }
    
    private var ratingScale: some View {
        HStack(spacing: 2) {
            let starsCount = Int(nft.rating)
            
            ForEach(0..<starsCount, id: \.self) { _ in
                Image(systemName: "star.fill")
                    .resizable()
                    .frame(width: 12, height: 12)
                    .foregroundStyle(Color.yellowUniversalColor)
            }
            
            ForEach(0..<(5 - starsCount), id: \.self) { _ in
                Image(systemName: "star.fill")
                    .resizable()
                    .frame(width: 12, height: 12)
                    .foregroundStyle(Color.lightGreyColor)
            }
        }
    }
}
