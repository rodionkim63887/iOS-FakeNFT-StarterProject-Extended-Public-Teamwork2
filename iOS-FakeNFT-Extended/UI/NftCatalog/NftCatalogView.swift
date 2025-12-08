import SwiftUI
import ProgressHUD

struct NftCatalogView: View {
    
    @Environment(Router.self) private var router

    @State private var viewModel: NftCatalogViewModel
    @State private var showError = false
    @State private var showSortMenu = false
    
    init(viewModel: NftCatalogViewModel) {
        _viewModel = State(initialValue: viewModel)
    }
    
    var body: some View {
        ZStack {
            Group {
                VStack {
                    headerView
                    collectionsList
                }
            }
            .task {
                await viewModel.loadCollections()
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
            .networkErrorAlert(
                isPresented: $showError,
                retry: { await viewModel.retry() }
            )
            
            if showSortMenu {
                VStack {
                    SortMenuOverlay(
                        showMenu: $showSortMenu,
                        sortByName: { viewModel.sortByName() },
                        sortByCount: { viewModel.sortByItemsCount() }
                    )
                }
            }
        }
        .toolbar(showSortMenu ? .hidden : .visible, for: .tabBar)
    }
    
    private var headerView: some View {
        HStack {
            Spacer()
            
            Button {
                showSortMenu = true
            } label: {
                MenuButtonImage()
            }
            .padding(.trailing, 9)
        }
    }
    
    private var collectionsList: some View {
        List {
            ForEach(viewModel.collections) { collection in
                Button {
                    router.push(.nftCollectionDetail(collection: collection))
                } label: {
                    NftCollectionCell(nftCollection: collection)
                        .padding(.horizontal, 16)
                }
                .buttonStyle(.plain)
                .listRowSeparator(.hidden)
                .listRowInsets(EdgeInsets())
            }
        }
        .listStyle(.plain)
    }
}


#Preview("CollectionList") {
    NftCatalogView(
        viewModel: NftCatalogViewModel(
            service: MockCollectionService()
        )
    )
    .environment(Router())
}

#Preview("Error") {
    NftCatalogView(
        viewModel: NftCatalogViewModel(
            service: MockErrorCollectionService(),
            
        )
    )
    .environment(Router())
}
