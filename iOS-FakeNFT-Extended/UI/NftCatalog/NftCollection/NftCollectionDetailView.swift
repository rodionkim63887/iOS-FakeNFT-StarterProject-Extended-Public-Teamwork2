import SwiftUI
import ProgressHUD

struct NftCollectionDetailView: View {
    @Environment(Router.self) private var router
    
    @State private var viewModel: NftCollectionViewModel
    @State private var showError = false
    
    let collection: NftCollectionViewData
    
    init(collection: NftCollectionViewData, viewModel: NftCollectionViewModel) {
        self.collection = collection
        _viewModel = State(initialValue: viewModel)
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                titleImage
                collectionInfo
            }
        }
        .task {
            await viewModel.loadNfts()
        }
        .onChange(of: viewModel.isLoading) { _, isLoading in
            if isLoading {
                ProgressHUD.animate()
            } else {
                ProgressHUD.dismiss()
            }
        }
        .onChange(of: viewModel.errorMessage) { _, message in
            showError = message != nil
        }
        .ignoresSafeArea(edges: .top)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    router.pop()
                } label: {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundStyle(.blackUniversal)
                }
            }
        }
        .toolbarBackground(.clear, for: .navigationBar)
        .networkErrorAlert(
            isPresented: $showError,
            retry: { await viewModel.retry() }
        )
    }
    
    private var titleImage: some View {
        KFImageView(
            url: collection.imageUrl,
            contentMode: .fill,
            height: 310,
            cornerRadius: 12
        )
    }
    
    private var collectionInfo: some View {
        VStack(alignment: .leading) {
            
            Text(collection.title)
                .font(.bold22)
                .padding(.bottom, 8)
            
            HStack(alignment: .bottom) {
                Text("Автор коллекции:")
                    .font(.regular13)
                Button {
                    
                } label: {
                    Text(collection.author ?? "John Doe")
                        .font(.regular15)
                }
            }
            .padding(.bottom, 5)
            
            Text(collection.description ?? "")
                .font(.regular13)
                .foregroundStyle(.blackUniversal)
                .padding(.bottom, 16)
            
            nftSection
        }
        .padding(16)
    }
    
    private var nftSection: some View {
        NftGridView(viewModel: viewModel)
    }
}

#Preview("Collection Detail (Mock)") {
    let mockService = MockNftService()

    let previewCollection = NftCollectionViewData(
        id: "123",
        title: "Peach Demo",
        imageUrl: URL(string: "https://code.s3.yandex.net/Mobile/iOS/NFT/Обложки_коллекций/Peach.png"),
        itemsCount: 4,
        description: "curabitur feugait a definitiones singulis movet eros aeque mucius evertitur assueverit et eam",
        author: "John Doe",
        nftIds: PreviewNfts.map { $0.id }
    )

    let vm = NftCollectionViewModel(
        service: mockService,
        nftIds: previewCollection.nftIds
    )

    NavigationStack {
        NftCollectionDetailView(collection: previewCollection, viewModel: vm)
    }
    .environment(Router())
    .environment(CartStore())
}
