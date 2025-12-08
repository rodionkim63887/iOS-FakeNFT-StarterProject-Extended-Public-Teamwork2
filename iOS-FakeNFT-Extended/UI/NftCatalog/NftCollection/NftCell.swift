import SwiftUI
import Kingfisher

struct NftCell: View {
    
    let nft: Nft
    let isLiked: Bool
    let isInCart: Bool
    let onToggleLike: () -> Void
    let onToggleCart: () -> Void
    
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
        KFImageView(
            url: URL(string: nft.images.first ?? ""),
            contentMode: .fit,
            height: nil,
            cornerRadius: 12,
        )
        .overlay(alignment: .topTrailing) {
            LikeToggleButton(isLiked: isLiked, action: onToggleLike)
        }
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
        CartToggleButton(isInCart: isInCart, onToggle: onToggleCart)
    }
}

#Preview("Two NFT Cells") {
    HStack(spacing: 16) {
        NftCell(
            nft: MockNftData.nft1,
            isLiked: true,
            isInCart: false,
            onToggleLike: {},
            onToggleCart: {}
        )
        .frame(width: 108)

        NftCell(
            nft: MockNftData.nft2,
            isLiked: false,
            isInCart: true,
            onToggleLike: {},
            onToggleCart: {}
        )
        .frame(width: 108)
    }
    .padding()
}
