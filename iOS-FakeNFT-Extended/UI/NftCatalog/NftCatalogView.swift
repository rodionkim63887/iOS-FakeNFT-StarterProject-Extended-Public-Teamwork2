import SwiftUI
import ProgressHUD

struct NftCatalogView: View {
    
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
                Image("MenuButton")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 21)
                    .foregroundStyle(.black)
            }
        }
        .padding(.top, 2)
        .padding(.horizontal, 20)
    }
    
    private var collectionsList: some View {
        List {
            ForEach(viewModel.collections) { collection in
                NftCollectionCell(nftCollection: collection)
                    .listRowSeparator(.hidden)
                    .listRowInsets(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
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
}

#Preview("Error") {
    NftCatalogView(
        viewModel: NftCatalogViewModel(
            service: MockErrorCollectionService(),
            
        )
    )
}
