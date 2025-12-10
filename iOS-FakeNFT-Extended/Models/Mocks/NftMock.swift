import Foundation

struct NftMock: Identifiable {
    let id = UUID()
    let name: String
    let rating: Double
    let price: Double
    let image: String
}

enum MockData {
    static let nftMock1 = NftMock(name: "April", rating: 1.4, price: 2.78, image: "MockNFTCard1")
    static let nftMock2 = NftMock(name: "Greena", rating: 3.2, price: 3.78, image: "MockNFTCard2")
    static let nftMock3 = NftMock(name: "Spring", rating: 4.6, price: 1.78, image: "MockNFTCard3")
}
