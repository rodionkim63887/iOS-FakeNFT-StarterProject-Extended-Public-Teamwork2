import Foundation
import Observation

struct NftCollectionViewData: Identifiable {
    let id: String
    let title: String
    let imageUrl: URL?
    let itemsCount: Int
    
    init(model: NftCollection) {
        self.id = model.id
        self.title = model.name
        self.imageUrl = URL(string: model.cover)
        self.itemsCount = model.nfts.count
    }
    
    // Preview init()
    init(
        id: String,
        title: String,
        imageUrl: URL?,
        itemsCount: Int
    ) {
        self.id = id
        self.title = title
        self.imageUrl = imageUrl
        self.itemsCount = itemsCount
    }
}

@Observable
@MainActor
final class NftCatalogViewModel {
    
    private let service: CollectionsService
    
    var collections: [NftCollectionViewData] = []
    var isLoading = false
    var errorMessage: String? = nil
    
    init(service: CollectionsService) {
        self.service = service
    }
    
    func loadCollections() async {
        isLoading = true
        
        do {
            let result = try await service.loadCollections()
            collections = result.map { NftCollectionViewData(model: $0) }
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
        collections.sort { $0.title.localizedCompare($1.title) == .orderedAscending }
    }
    
    func sortByItemsCount() {
        collections.sort { $0.itemsCount > $1.itemsCount }
    }
}
