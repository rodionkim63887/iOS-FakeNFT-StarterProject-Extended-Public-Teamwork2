import Foundation

let PreviewNfts: [Nft] = [
    Nft(
        id: "a4edeccd-ad7c-4c7f-b09e-6edec02a812b",
        name: "Daryl Lucas",
        description: "animal solet pharetra perpetua usu alienum",
        author: "https://strange_gates.fakenfts.org/",
        price: 43.53,
        images: [
            "https://code.s3.yandex.net/Mobile/iOS/NFT/Peach/Nacho/1.png",
            "https://code.s3.yandex.net/Mobile/iOS/NFT/Peach/Nacho/2.png",
            "https://code.s3.yandex.net/Mobile/iOS/NFT/Peach/Nacho/3.png"
        ],
        rating: 2,
        createdAt: "2023-06-08T05:52:06.646Z[GMT]"
    ),
    Nft(
        id: "83c23ccc-1368-4da8-b54d-76c9b235835b",
        name: "Raul Juarez",
        description: "persius dictumst sit dui sagittis solum primis perpetua",
        author: "https://crazy_hoover.fakenfts.org/",
        price: 40.48,
        images: [
            "https://code.s3.yandex.net/Mobile/iOS/NFT/Brown/Bitsy/1.png",
            "https://code.s3.yandex.net/Mobile/iOS/NFT/Brown/Bitsy/2.png",
            "https://code.s3.yandex.net/Mobile/iOS/NFT/Brown/Bitsy/3.png"
        ],
        rating: 1,
        createdAt: "2023-08-12T05:55:23.445Z[GMT]"
    ),
    Nft(
        id: "3434c774-0e0f-476e-a314-24f4f0dfed86",
        name: "Rudolph Short",
        description: "praesent numquam commodo singulis labores dolor intellegat an orci",
        author: "https://tender_solomon.fakenfts.org/",
        price: 25.42,
        images: [
            "https://code.s3.yandex.net/Mobile/iOS/NFT/Gray/Butter/1.png",
            "https://code.s3.yandex.net/Mobile/iOS/NFT/Gray/Butter/2.png",
            "https://code.s3.yandex.net/Mobile/iOS/NFT/Gray/Butter/3.png"
        ],
        rating: 2,
        createdAt: "2023-08-20T05:02:45.672Z[GMT]"
    ),
    Nft(
        id: "c14cf3bc-7470-4eec-8a42-5eaa65f4053c",
        name: "Myrna Cervantes",
        description: "eloquentiam deterruisset tractatos repudiandae nunc a electram",
        author: "https://priceless_leavitt.fakenfts.org/",
        price: 39.37,
        images: [
            "https://code.s3.yandex.net/Mobile/iOS/NFT/Beige/Ellsa/1.png",
            "https://code.s3.yandex.net/Mobile/iOS/NFT/Beige/Ellsa/2.png",
            "https://code.s3.yandex.net/Mobile/iOS/NFT/Beige/Ellsa/3.png"
        ],
        rating: 5,
        createdAt: "2023-09-27T23:48:21.462Z[GMT]"
    )
]

final class MockNftService: NftService {
    private let mock = PreviewNfts
    
    func loadNft(id: String) async throws -> Nft {
        mock.first { $0.id == id } ?? mock.first!
    }
}
