import SwiftUI
import Kingfisher

struct NftCollectionDetailView: View {
    @Environment(Router.self) private var router
    
    @State private var viewModel: NftCollectionViewModel
    
    let collection: NftCollectionViewData
    
    init(collection: NftCollectionViewData, viewModel: NftCollectionViewModel) {
        self.collection = collection
        _viewModel = State(initialValue: viewModel)
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                titleImage
                
                collectionInfo
            }
        }
        .task {
            await viewModel.loadNfts()
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
    }
    
    private var titleImage: some View {
        KFImage(collection.imageUrl)
            .resizable()
            .scaledToFill()
            .frame(height: 310)
            .cornerRadius(12)
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
            
            nftSection
        }
    }
    
    private var nftSection: some View {
        NftGridView(nfts: viewModel.nfts)
    }
}

#Preview("Collection Detail") {
    let previewServices = ServicesAssembly(
        networkClient: DefaultNetworkClient(),
        nftStorage: NftStorageImpl()
    )
    
    let previewCollection = NftCollectionViewData(
        id: "123",
        title: "Singulis Epicuri",
        imageUrl: URL(string: "https://code.s3.yandex.net/Mobile/iOS/NFT/Обложки_коллекций/Brown.png"),
        itemsCount: 3,
        description: "Curabitur feugait a definitiones singulis movet eros aeque mucius evertitur assueverit et eam.",
        author: "Lourdes Harper",
        nftIds: [
            "c14cf3bc-7470-4eec-8a42-5eaa65f4053c",
            "d6a02bd1-1255-46cd-815b-656174c1d9c0",
            "f380f245-0264-4b42-8e7e-c4486e237504"
        ]
    )
    
    let previewVM = NftCollectionViewModel(
        service: previewServices.nftService,
        nftIds: previewCollection.nftIds
    )
    
    NavigationStack {
        NftCollectionDetailView(
            collection: previewCollection,
            viewModel: previewVM
        )
    }
    .environment(Router())
}
