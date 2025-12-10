import Foundation
import Observation

struct NftCollectionViewData: Identifiable, Hashable {
    let id: String
    let title: String
    let imageUrl: URL?
    let itemsCount: Int
    let description: String?
    let author: String?
    let nftIds: [String]
    
    init(model: NftCollection) {
        self.id = model.id
        self.title = model.name
        self.imageUrl = URL(string: model.cover)
        let uniqueIds = Array(Set(model.nfts))
        self.itemsCount = uniqueIds.count
        self.description = model.description
        self.author = model.author
        self.nftIds = uniqueIds
    }
    
    // Preview init()
    init(
        id: String,
        title: String,
        imageUrl: URL?,
        itemsCount: Int,
        description: String? = nil,
        author: String? = nil,
        nftIds: [String] = []
    ) {
        self.id = id
        self.title = title
        self.imageUrl = imageUrl
        self.itemsCount = itemsCount
        self.description = description
        self.author = author
        self.nftIds = nftIds
    }
}

enum NftSortType: String {
    case name
    case itemsCount
}

@Observable
@MainActor
final class NftCatalogViewModel {
    
    private let service: CollectionsService
    private let sortKey = "nft_catalog_sort_type"
    
    var collections: [NftCollectionViewData] = []
    var isLoading = false
    var errorMessage: String? = nil
    
    var sortType: NftSortType {
        didSet { UserDefaults.standard.set(sortType.rawValue, forKey: sortKey) }
    }
    
    init(service: CollectionsService) {
        self.service = service
        
        if let raw = UserDefaults.standard.string(forKey: sortKey),
           let saved = NftSortType(rawValue: raw) {
            self.sortType = saved
        } else {
            self.sortType = .name
        }
    }
    
    private func applySorting() {
        switch sortType {
        case .name:
            sortByName()
        case .itemsCount:
            sortByItemsCount()
        }
    }
    
    func loadCollections() async {
        isLoading = true
        
        do {
            let result = try await service.loadCollections()
            collections = result.map { NftCollectionViewData(model: $0) }
            applySorting()
        } catch {
            errorMessage = error.localizedDescription
            collections = []
        }
        
        isLoading = false
    }
    
    func retry() async {
        await loadCollections()
    }
    
    func sortByName() {
        sortType = .name
        collections.sort { $0.title.localizedCompare($1.title) == .orderedAscending }
    }
    
    func sortByItemsCount() {
        sortType = .itemsCount
        collections.sort {
            if $0.itemsCount == $1.itemsCount {
                return $0.title.localizedCompare($1.title) == .orderedAscending
            }
            
            return $0.itemsCount > $1.itemsCount
        }
    }
}

