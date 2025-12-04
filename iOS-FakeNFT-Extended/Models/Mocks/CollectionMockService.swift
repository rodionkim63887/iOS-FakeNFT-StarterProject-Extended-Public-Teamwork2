import Foundation

final class MockCollectionService: CollectionService {
    func loadCollections() async throws -> [NftCollection] {
        return [
            NftCollection(
                id: "1",
                name: "Peach",
                cover: "https://code.s3.yandex.net/Mobile/iOS/NFT/Обложки_коллекций/Peach.png",
                description: "",
                author: "Me",
                createdAt: .now,
                nfts: ["1", "2"]
            ),
            NftCollection(
                id: "2",
                name: "Brown",
                cover: "https://code.s3.yandex.net/Mobile/iOS/NFT/Обложки_коллекций/Brown.png",
                description: "",
                author: "Me",
                createdAt: .now,
                nfts: ["1", "2", "3", "4"]
            ),
            NftCollection(
                id: "3",
                name: "White",
                cover: "https://code.s3.yandex.net/Mobile/iOS/NFT/Обложки_коллекций/White.png",
                description: "",
                author: "Me",
                createdAt: .now,
                nfts: ["1", "2", "3"]
            ),
        ]
    }
}

final class MockErrorCollectionService: CollectionService {
    func loadCollections() async throws -> [NftCollection] {
        throw URLError(.badServerResponse)
    }
}
