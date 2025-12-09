import SwiftUI

struct NftGridView: View {
    
    @Environment(Router.self) private var router
    
    @Bindable var viewModel: NftCollectionViewModel
    
    @State private var selectedNftId: String? = nil
    
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
                    Button {
                        selectedNftId = nft.id
                    } label: {
                        NftCell(
                            nft: nft,
                            isLiked: viewModel.isLiked(nft.id),
                            isInCart: viewModel.isInCart(nft),
                            onToggleLike: { viewModel.toggleLike(for: nft.id) },
                            onToggleCart: { viewModel.toggleCart(nft) }
                        )
                    }
                    .buttonStyle(.plain)
                }
            }
        }
        .sheet(item: $selectedNftId) { id in
            NftDetailBridgeView(id: id)
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
