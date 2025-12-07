import SwiftUI
import Kingfisher

struct NftCell: View {
    @Environment(CartStore.self) private var cart
    
    let nft: Nft
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            
            titleImage
            
            NftRatingView(rating: Int(nft.rating))
            
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    nftTitle
                    nftPrice
                }
                
                toggleCartButton
            }
        }
    }
    
    private var titleImage: some View {
        KFImage(URL(string: nft.images[0]))
            .resizable()
            .aspectRatio(contentMode: .fit)
            .cornerRadius(12)
            .overlay(alignment: .topTrailing) {
                toggleLikeButton
            }
    }
    
    private var toggleLikeButton: some View {
        Button() {
            print("Toggle like!")
            // TODO: Implement favorites functionality within UserProfile
        } label: {
            Image(systemName: "heart.fill")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 18)
                .foregroundStyle(Color(.whiteUniversal))
        }
        .frame(width: 42, height: 42)
    }
    
    private var nftTitle: some View {
        Text(nft.name)
            .font(.bold17)
            .lineLimit(1)
    }
    
    private var nftPrice: some View {
        Text(String(format: "%.2f ETH", nft.price))
            .font(.medium10)
    }
    
    private var toggleCartButton: some View {
        Button() {
            if cart.items.contains(where: { $0.id == nft.id }) {
                cart.remove(nft)
            } else {
                cart.add(nft)
            }
        } label: {
            Image(
                cart.items.contains(where: { $0.id == nft.id })
                ? "DeleteFromCart"
                : "AddToCart"
            )
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 16)
            .foregroundStyle(Color(.blackUniversal))
        }
    }
}

#Preview("Two NFT Cells") {
    HStack(spacing: 16) {
        NftCell(nft: MockNftData.nft1)
            .frame(width: 108)
        
        NftCell(nft: MockNftData.nft2)
            .frame(width: 108)
    }
    .environment(CartStore())
    .padding()
    .previewLayout(.sizeThatFits)
}
