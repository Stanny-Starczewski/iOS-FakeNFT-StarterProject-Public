//
//  NetworkService.swift
//  FakeNFT
//
//  Created by Anton Vikhlyaev on 16.07.2023.
//

import Foundation

protocol NetworkServiceProtocol {
    func getCollections(_ completion: @escaping (Result<[Collection], Error>) -> Void)
    func getOrder(_ completion: @escaping (Result<Order, Error>) -> Void)
    func getNft(by id: String, _ completion: @escaping (Result<Item, Error>) -> Void)
    func getAuthor(by id: String, _ completion: @escaping (Result<Author, Error>) -> Void)
    func getProfile(_ completion: @escaping (Result<Profile, Error>) -> Void)
    func getMyNft(_ completion: @escaping (Result<[Item], Error>) -> Void)
    func getFavorites(_ completion: @escaping (Result<[Item], Error>) -> Void)
    func getFavorites(_ completion: @escaping (Result<Favorites, Error>) -> Void)
    func getCart(_ completion: @escaping (Result<[Item], Error>) -> Void)
    func getCurrencies(_ completion: @escaping (Result<[Currency], Error>) -> Void)
    func updateCart(nftsInCart: Order, _ completion: @escaping (Error?) -> Void)
    func updateFavorites(favorites: Favorites, _ completion: @escaping (Error?) -> Void)
    func updateProfile(profile: Profile, _ completion: @escaping (Error?) -> Void)
    func paymentWithIdCurrency(id: String, _ completion: @escaping (Result<PaymentStatus, Error>) -> Void)
}

final class NetworkService {
    
    // MARK: - Properties
    
    private let client: NetworkClient
    
    // MARK: - Life Cycle
    
    init(client: NetworkClient = DefaultNetworkClient()) {
        self.client = client
    }
    
    // MARK: - Private methods
    
    private func handleResult<T>(_ result: Result<T, Error>, completion: @escaping (Result<T, Error>) -> Void) {
        switch result {
        case .success(let success):
            DispatchQueue.main.async {
                completion(.success(success))
            }
        case .failure(let failure):
            DispatchQueue.main.async {
                completion(.failure(failure))
            }
        }
    }

    private func fetchCart(nftsInCart: Order, _ completion: @escaping (Result<[Item], Error>) -> Void) {
        var nftItems: [Item] = []
        let group = DispatchGroup()
        nftsInCart.nfts.forEach {
            group.enter()
            getNft(by: $0) { result in
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
    
    private func fetchNftsIdInMyNFT(_ completion: @escaping (Result<Order, Error>) -> Void) {
        let request = GetProfileRequest()
        client.send(request: request, type: Order.self) { [weak self] result in
            self?.handleResult(result, completion: completion)
        }
    }
    
    private func fetchMyNFT(nftsInCart: Order, _ completion: @escaping (Result<[Item], Error>) -> Void) {
        var nftItems: [Item] = []
        let group = DispatchGroup()
        nftsInCart.nfts.forEach {
            group.enter()
            client.send(request: GetNftByIdRequest(id: $0), type: Item.self) { [weak self] result in
                switch result {
                case .success(let nftItem):
                    self?.getAuthor(by: nftItem.author, { result in
                        switch result {
                        case .success(let author):
                            let newNftItem = Item(
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
    
    private func fetchFavorites(nftsInCart: Favorites, _ completion: @escaping (Result<[Item], Error>) -> Void) {
        var nftItems: [Item] = []
        let group = DispatchGroup()
        nftsInCart.likes.forEach {
            group.enter()
            client.send(request: GetNftByIdRequest(id: $0), type: Item.self) { result in
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

// MARK: - CartNetworkServiceProtocol

extension NetworkService: NetworkServiceProtocol {
    func getCollections(_ completion: @escaping (Result<[Collection], Error>) -> Void) {
        let request = GetCollectionsRequest()
        client.send(request: request, type: [Collection].self) { [weak self] result in
            self?.handleResult(result, completion: completion)
        }
    }
    
    func getOrder(_ completion: @escaping (Result<Order, Error>) -> Void) {
        let request = GetOrdersRequest()
        client.send(request: request, type: Order.self) { [weak self] result in
            self?.handleResult(result, completion: completion)
        }
    }
    
    func getNft(by id: String, _ completion: @escaping (Result<Item, Error>) -> Void) {
        let request = GetNftByIdRequest(id: id)
        client.send(request: request, type: Item.self) { [weak self] result in
            self?.handleResult(result, completion: completion)
        }
    }
    
    func getAuthor(by id: String, _ completion: @escaping (Result<Author, Error>) -> Void) {
        let request = GetAuthorByIdRequest(id: id)
        client.send(request: request, type: Author.self) { [weak self] result in
            self?.handleResult(result, completion: completion)
        }
    }
    
    func getProfile(_ completion: @escaping (Result<Profile, Error>) -> Void) {
        let request = GetProfileRequest()
        client.send(request: request, type: Profile.self) { [weak self] result in
            self?.handleResult(result, completion: completion)
        }
    }
    
    func getCart(_ completion: @escaping (Result<[Item], Error>) -> Void) {
        getOrder { [weak self] result in
            switch result {
            case .success(let nftsInCart):
                self?.fetchCart(nftsInCart: nftsInCart) { [weak self] result in
                    self?.handleResult(result, completion: completion)
                }
            case .failure(let error):
                self?.handleResult(.failure(error), completion: completion)
            }
        }
    }
    
    func getMyNft(_ completion: @escaping (Result<[Item], Error>) -> Void) {
        fetchNftsIdInMyNFT { [weak self] result in
            switch result {
            case .success(let nftsInCart):
                self?.fetchMyNFT(nftsInCart: nftsInCart) { [weak self] result in
                    self?.handleResult(result, completion: completion)
                }
            case .failure(let error):
                self?.handleResult(.failure(error), completion: completion)
            }
        }
    }
    
    func getFavorites(_ completion: @escaping (Result<[Item], Error>) -> Void) {
        getFavorites { [weak self] result in
            switch result {
            case .success(let nftsInCart):
                self?.fetchFavorites(nftsInCart: nftsInCart) { [weak self] result in
                    self?.handleResult(result, completion: completion)
                }
            case .failure(let error):
                self?.handleResult(.failure(error), completion: completion)
            }
        }
    }
    
    func getFavorites(_ completion: @escaping (Result<Favorites, Error>) -> Void) {
        let request = GetProfileRequest()
        client.send(request: request, type: Favorites.self) { [weak self] result in
            self?.handleResult(result, completion: completion)
        }
    }
    
    func getCurrencies(_ completion: @escaping (Result<[Currency], Error>) -> Void) {
        let request = GetCurrenciesRequest()
        client.send(request: request, type: [Currency].self) { [weak self] result in
            self?.handleResult(result, completion: completion)
        }
    }
    
    func updateCart(nftsInCart: Order, _ completion: @escaping (Error?) -> Void) {
        let request = ChangeOrdersRequest(dto: nftsInCart)
        client.send(request: request) { result in
            switch result {
            case .success:
                DispatchQueue.main.async {
                    completion(nil)
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    completion(error)
                }
            }
        }
    }
    
    func updateProfile(profile: Profile, _ completion: @escaping (Error?) -> Void) {
        let request = ChangeProfileRequest(dto: profile)
        client.send(request: request) { result in
            switch result {
            case .success:
                DispatchQueue.main.async {
                    completion(nil)
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    completion(error)
                }
            }
        }
    }
    
    func updateFavorites(favorites: Favorites, _ completion: @escaping (Error?) -> Void) {
        let request = ChangeProfileRequest(dto: favorites)
        client.send(request: request) { result in
            switch result {
            case .success:
                DispatchQueue.main.async {
                    completion(nil)
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    completion(error)
                }
            }
        }
    }
    
    func paymentWithIdCurrency(id: String, _ completion: @escaping (Result<PaymentStatus, Error>) -> Void) {
        let request = PaymentWithIdCurrencyRequest(id: id)
        client.send(request: request, type: PaymentStatus.self) { [weak self] result in
            self?.handleResult(result, completion: completion)
        }
    }
}
