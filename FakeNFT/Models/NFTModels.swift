
import Foundation

struct NFTCollection: Decodable {
    let createdAt: String
    let name: String
    let cover: String
    let nfts: [String]
    let description: String
    let author: String
}
struct NftCollectionAuthor: Codable {
    let name: String
    let website: String
}

struct NftCollectionListItem {
    let id: Int
    let name: String
    let cover: String
    let nftsCount: Int
}

struct NFTCollectionNFTItem {
    let id: Int
    let image: String
    let rating: Int
    let name: String
    let price: Double
    let liked: Bool
    let inCart: Bool
}

struct NftItem: Codable, Equatable {
    let createdAt: String
    let name: String
    let images: [String]
    let rating: Int
    let description: String
    let price: Double
    let id: String
}

struct NftLiked: Codable {
    let likes: [Int]
}

struct NftsInCart: Codable {
    let nfts: [String]
}

struct NFTModel: Decodable {
     let id: String
     let createdAt: String
     let name: String
     let images: [String]
     let rating: Int
     let description: String
     let price: Double
     let author: String
 }

struct NFTViewModel {
    let id: String
    let name: String
    let imageURL: URL
    let rating: Int
    let price: Double
    let isOrdered: Bool
    let isLiked: Bool
}

struct AuthorModel: Decodable {
    let id: String
    let name: String
    let website: String
}

struct FavoritesModel: Decodable {
    let likes: [String]
}

struct OrderModel: Decodable { 
    let id: String
    let nfts: [String]
}

struct NftsFavorites: Codable {
    let likes: [String]
}

struct NFTNetworkModel: Codable, Equatable {
    let createdAt: String
    let name: String
    let images: [String]
    let rating: Int
    let description: String
    let price: Float
    let author: String
    let id: String
}

struct AuthorNetworkModel: Codable {
    let name: String
    let id: String
}
