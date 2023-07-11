//
//  Protocols.swift
//  FakeNFT
//
//  Created by Alexander Farizanov on 03.07.2023.
//

import Foundation
protocol CryptoConverterProtocol {
    func convertUSD(to: CryptoCoin, amount: Double) -> Double
    func getCryptocurrencies() -> [Cryptocurrency]
}

protocol CollectionViewModelProtocol {
    var onNFTCollectionInfoUpdate: (() -> Void)? { get set }
    var onNFTAuthorUpdate: (() -> Void)? { get set }
    var onNFTItemsUpdate: (() -> Void)? { get set }
    var onNFTChanged: (() -> Void)? { get set }
    var showAlertClosure: (() -> Void)? { get set }
    var errorMessage: String? { get }
    var updateLoadingStatus: (() -> Void)? { get set }
    var isLoading: Bool { get set }
    var nftCollection: NFTCollection? { get }
    var nftCollectionAuthor: NFTCollectionAuthor? { get }
    var nftCollectionItems: [NFTCollectionNFTItem]? { get }
    var nftCollectionItemsCount: Int? { get }
    var converter: CryptoConverterProtocol { get }

    func getNFTCollectionInfo()
    func getNFTCollectionAuthor(id: Int)
    func getNFTCollectionItems()
    func toggleCart(id: Int)
    func toggleLike(id: Int)
}

protocol CollectionModelProtocol {
    var networkClient: NetworkClient { get }
    func getData<T: Decodable>(url: String, type: T.Type, completion: @escaping (Result<T, Error>) -> Void)
    func toggleNFTItemInCart(id: Int, completion: @escaping (Result<Order, Error>) -> Void)
    func toggleNFTLikeInProfile(id: Int, completion: @escaping (Result<Profile, Error>) -> Void)
}


protocol CatalogViewModelProtocol {
    var onNFTCollectionsUpdate: (() -> Void)? { get set }
    var showAlertClosure: (() -> Void)? { get set }
    var errorMessage: String? { get }
    var updateLoadingStatus: (() -> Void)? { get set }
    var isLoading: Bool { get set }
    var NFTCollections: [NFTCollection]? { get }
    var NFTCollectionsList: [NFTCollectionListItem]? { get }
    var model: CatalogModelProtocol { get }
    var NFTCollectionsCount: Int? { get }
    func getNFTCollections()
    func getCellViewModel(at indexPath: IndexPath) -> NFTCollectionListItem?
    func sortNFTCollections(by: SortAttribute)
}

protocol CatalogModelProtocol {
    var networkClient: NetworkClient { get }
    func getData<T: Decodable>(url: String, type: T.Type, completion: @escaping (Result<T, Error>) -> Void)
}
