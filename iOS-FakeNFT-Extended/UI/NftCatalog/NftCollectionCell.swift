import SwiftUI
import Kingfisher

struct NftCollectionCell: View {
    
    let nftCollection: NftCollectionViewData
    
    var body: some View {
            VStack(alignment: .leading, spacing: 4) {

                KFImageView(
                    url: nftCollection.imageUrl,
                    contentMode: .fill,
                    height: 140,
                    cornerRadius: 12
                )

                Text("\(nftCollection.title) (\(nftCollection.itemsCount))")
                    .font(.bold17)
                    .foregroundStyle(.blackUniversal)
            }
            .padding(.vertical, 6)
        }
}

#Preview {
    let previewData = NftCollectionViewData(
        id: "id",
        title: "Peach",
        imageUrl: URL(string: "https://code.s3.yandex.net/Mobile/iOS/NFT/Обложки_коллекций/Peach.png"),
        itemsCount: 11
    )
    
    NftCollectionCell(nftCollection: previewData)
        .padding(.horizontal, 16)
}
