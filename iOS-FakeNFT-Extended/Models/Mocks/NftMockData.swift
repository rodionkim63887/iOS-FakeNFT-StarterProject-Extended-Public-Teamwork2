import Foundation

enum MockNftData {
    static let nft1 = Nft(
        id: "7773e33c-ec15-4230-a102-92426a3a6d5a",
        name: "Rosario Dejesus",
        description: "explicari lobortis rutrum evertitur fugit convenire ligula",
        author: "https://unruffled_cohen.fakenfts.org/",
        price: 28.27,
        imagesUrlsString: [
            "https://code.s3.yandex.net/Mobile/iOS/NFT/Beige/Finn/1.png",
            "https://code.s3.yandex.net/Mobile/iOS/NFT/Beige/Finn/2.png",
            "https://code.s3.yandex.net/Mobile/iOS/NFT/Beige/Finn/3.png"
        ],
        rating: 3,
        createdAt: "2023-10-08T07:43:22.944Z[GMT]"
    )
    
    static let nft2 = Nft(
        id: "cc74e9ab-2189-465f-a1a6-8405e07e9fe4",
        name: "James Burt",
        description: "eos habeo percipit duis malesuada",
        author: "https://exciting_pare.fakenfts.org/",
        price: 11.14,
        imagesUrlsString: [
            "https://code.s3.yandex.net/Mobile/iOS/NFT/Blue/Clover/1.png",
            "https://code.s3.yandex.net/Mobile/iOS/NFT/Blue/Clover/2.png",
            "https://code.s3.yandex.net/Mobile/iOS/NFT/Blue/Clover/3.png"
        ],
        rating: 2,
        createdAt: "2023-07-11T05:27:40.359Z[GMT]"
    )
    
    static let sampleList = [nft1, nft2]
}
