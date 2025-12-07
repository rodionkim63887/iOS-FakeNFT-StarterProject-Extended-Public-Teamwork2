import SwiftUI

struct NftGridView: View {
    
    @Bindable var viewModel: NftCollectionViewModel
    
    private let columnSpacing: CGFloat = 9
    private let columnsCount: Int = 3
    
    private var columns: [GridItem] {
        Array(
            repeating: GridItem(.flexible(), spacing: columnSpacing),
            count: columnsCount
        )
    }
    
    var body: some View {
        LazyVGrid(columns: columns, spacing: 28) {
            if viewModel.isLoading {
                let nftsCount = viewModel.nftIds.count
                
                ForEach(0..<nftsCount, id: \.self) { _ in
                    placeholderCell
                }
            } else {
                ForEach(viewModel.nfts) { nft in
                    NftCell(nft: nft)
                }
            }
        }
    }
    
    private var placeholderCell: some View {
        VStack(spacing: 8) {
            ProgressView()
                .progressViewStyle(.circular)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 52)
        }
    }
}
