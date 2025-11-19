import SwiftUI

struct ProductInCart: View {
    let viewModel: CartViewModel
    let nft: NftMock
    
    var body: some View {
        ZStack {
            Color.primaryColor
                .ignoresSafeArea()
            
            HStack(spacing: 20) {
                Image(nft.image)
                    .resizable()
                    .scaledToFit()
                    .clipShape(
                        RoundedRectangle(cornerRadius: 12)
                    )
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(nft.name)
                        .font(.bold17)
                    
                    ratingScale
                    
                    Spacer()
                    
                    Text("Цена")
                        .font(.regular13)
                    
                    Text("\(String(format: "%.2f", nft.price)) ETH")
                        .font(.bold17)
                }
                .padding(.vertical, 8)
                
                Spacer()
                
                Button {
                    print("Delete")
                    viewModel.tryDeletingFromCart(nft: nft)
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
            let starsCount = Int(nft.rating.rounded())
            
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
