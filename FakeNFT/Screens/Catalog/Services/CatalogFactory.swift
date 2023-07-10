import Foundation

final class MockCatalogueProvider: CatalogueProviderProtocol {
    func getCollections(completion: @escaping (Result<[NFTCollection], Error>) -> Void) {
        let collections = [
            NFTCollection(id: "5",
                       createdAt: "",
                       name: "Peach",
                       cover: "https://code.s3.yandex.net/Mobile/iOS/NFT/Обложки_коллекций/Peach.png",
                       nfts: ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11"],
                       description: "Description",
                       author: "5"),
            NFTCollection(id: "2",
                       createdAt: "",
                       name: "Blue",
                       cover: "https://code.s3.yandex.net/Mobile/iOS/NFT/Обложки_коллекций/Blue.png",
                       nfts: ["1", "2", "3", "4", "5", "6"],
                       description: "Description",
                       author: "2"),
            NFTCollection(id: "3",
                       createdAt: "",
                       name: "Gray",
                       cover: "https://code.s3.yandex.net/Mobile/iOS/NFT/Обложки_коллекций/Gray.png",
                       nfts: ["1", "3", "5", "7", "9"],
                       description: "Description",
                       author: "3")
        ]
        completion(.success(collections))
    }
 }
