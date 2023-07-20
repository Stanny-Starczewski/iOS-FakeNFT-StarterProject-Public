//
//  NFTModels.swift
//  FakeNFT
//
//  Created by Alexander Farizanov on 03.07.2023.
//

import Foundation

struct NFTCollection: Decodable {
    let id: String
    let createdAt: String
    let name: String
    let cover: String
    let nfts: [String]
    let description: String
    let author: String
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

struct NFTItem: Codable {
    let createdAt: String
    let name: String
    let images: [String]
    let rating: Int
    let description: String
    let price: Double
    let id: String
}
struct NFTLiked: Codable {
    let likes: [Int]
}

struct NFTsInCart: Codable {
    let nfts: [Int]
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
