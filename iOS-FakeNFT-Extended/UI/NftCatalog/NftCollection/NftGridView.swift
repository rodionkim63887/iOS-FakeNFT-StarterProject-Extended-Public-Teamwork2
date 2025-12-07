import SwiftUI

struct NftGridView: View {
    let nfts: [Nft]

    private let columns = [
        GridItem(.flexible(), spacing: 12),
        GridItem(.flexible(), spacing: 12),
        GridItem(.flexible(), spacing: 12)
    ]
    
    var body: some View {
        LazyVGrid(columns: columns, spacing: 16) {
            ForEach(nfts) { nft in
                NftCell(nft: nft)
                    .frame(width: cellWidth)
            }
        }
    }

    private var cellWidth: CGFloat {
        let screenWidth = UIScreen.main.bounds.width
        let horizontalPadding: CGFloat = 16 * 2
        let columnSpacing: CGFloat = 12 * 2
        return (screenWidth - horizontalPadding - columnSpacing) / 3
    }
}
