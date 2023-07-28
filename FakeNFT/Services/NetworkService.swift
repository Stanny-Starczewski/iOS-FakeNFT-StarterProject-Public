//
//  NetworkService.swift
//  FakeNFT
//
//  Created by Andrei Kashin on 25.07.2023.
//

import Foundation

protocol NetworkServiceProtocol {
    func getMyNFT(_ completion: @escaping (Result<[NFTNetworkModel], Error>) -> Void)
    func getFavorites(_ completion: @escaping (Result<[NFTNetworkModel], Error>) -> Void)
}

final class NetworkService {
    // MARK: - Properties
    
    private let client: NetworkClient
    
    // MARK: - Life Cycle
    
    init(client: NetworkClient = DefaultNetworkClient()) {
        self.client = client
    }
    // MARK: - Private methods
    
    // MARK: - MyNFT Request
    
    private func fetchNftsIdInMyNFT(_ completion: @escaping (Result<NftsInCart, Error>) -> Void) {
        let request = GetProfileRequest()
        client.send(request: request, type: NftsInCart.self) { result in
            switch result {
            case .success(let nftsInCart):
                completion(.success(nftsInCart))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    private func fetchMyNFT(nftsInCart: NftsInCart, _ completion: @escaping (Result<[NFTNetworkModel], Error>) -> Void) {
        var nftItems: [NFTNetworkModel] = []
        let group = DispatchGroup()
        nftsInCart.nfts.forEach {
            group.enter()
            client.send(request: GetNftByIdRequest(id: $0), type: NFTNetworkModel.self) { [weak self] result in
                switch result {
                case .success(let nftItem):
                    self?.fetchAuthorName(by: nftItem.author, { result in
                        switch result {
                        case .success(let author):
                            let newNftItem = NFTNetworkModel(
                                createdAt: nftItem.createdAt,
                                name: nftItem.name,
                                images: nftItem.images,
                                rating: nftItem.rating,
                                description: nftItem.description,
                                price: nftItem.price,
                                author: author.name,
                                id: nftItem.id
                            )
                            nftItems.append(newNftItem)
                            group.leave()
                        case .failure(let error):
                            completion(.failure(error))
                        }
                    })
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
        group.notify(queue: .main) {
            completion(.success(nftItems))
        }
    }
    
    private func fetchAuthorName(by id: String, _ completion: @escaping (Result<AuthorNetworkModel, Error>) -> Void) {
        let request = GetAuthorByIdRequest(id: id)
        client.send(request: request, type: AuthorNetworkModel.self) { result in
            switch result {
            case .success(let author):
                completion(.success(author))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    // MARK: - Favorites Request
    
    private func fetchNftsIdFavorites(_ completion: @escaping (Result<NftsFavorites, Error>) -> Void) {
        let request = GetProfileRequest()
        client.send(request: request, type: NftsFavorites.self) { result in
            switch result {
            case .success(let nftsInCart):
                completion(.success(nftsInCart))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    private func fetchFavorites(nftsInCart: NftsFavorites, _ completion: @escaping (Result<[NFTNetworkModel], Error>) -> Void) {
        var nftItems: [NFTNetworkModel] = []
        let group = DispatchGroup()
        nftsInCart.likes.forEach {
            group.enter()
            client.send(request: GetNftByIdRequest(id: $0), type: NFTNetworkModel.self) { result in
                switch result {
                case .success(let nftItem):
                    nftItems.append(nftItem)
                    group.leave()
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
        group.notify(queue: .main) {
            completion(.success(nftItems))
        }
    }
}
// MARK: - NetworkServiceProtocol

extension NetworkService: NetworkServiceProtocol {
    func getMyNFT(_ completion: @escaping (Result<[NFTNetworkModel], Error>) -> Void) {
        fetchNftsIdInMyNFT { [weak self] result in
            switch result {
            case .success(let nftsInCart):
                self?.fetchMyNFT(nftsInCart: nftsInCart) { result in
                    switch result {
                    case .success(let nftItems):
                        DispatchQueue.main.async {
                            completion(.success(nftItems))
                        }
                    case .failure(let error):
                        DispatchQueue.main.async {
                            completion(.failure(error))
                        }
                    }
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
    }
    
    func getFavorites(_ completion: @escaping (Result<[NFTNetworkModel], Error>) -> Void) {
        fetchNftsIdFavorites { [weak self] result in
            switch result {
            case .success(let nftsInCart):
                self?.fetchFavorites(nftsInCart: nftsInCart) { result in
                    switch result {
                    case .success(let nftItems):
                        DispatchQueue.main.async {
                            completion(.success(nftItems))
                        }
                    case .failure(let error):
                        DispatchQueue.main.async {
                            completion(.failure(error))
                        }
                    }
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
    }
}
