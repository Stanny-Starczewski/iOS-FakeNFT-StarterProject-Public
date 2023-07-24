//
//  NFTModels.swift
//  FakeNFT
//
//  Created by Alexander Farizanov on 03.07.2023.
//

import Foundation

struct NFTCollection: Decodable {
    let createdAt: String
    let name: String
    let cover: String
    let nfts: [Int]
    let description: String
    let author: Int
    let id: String
}
struct NFTCollectionAuthor: Codable {
    let name: String
    let website: String
}

struct NFTCollectionListItem {
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

struct NFTNetworkModel: Codable {
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
