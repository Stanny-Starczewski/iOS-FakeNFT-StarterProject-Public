//
//  NetworkService.swift
//  FakeNFT
//
//  Created by Anton Vikhlyaev on 16.07.2023.
//

import Foundation

protocol CartNetworkServiceProtocol {
    func getCart(_ completion: @escaping (Result<[NftItem], Error>) -> Void)
    func updateCart(nftsInCart: NftsInCart, _ completion: @escaping (Error?) -> Void)
    func getCurrencies(_ completion: @escaping (Result<[Currency], Error>) -> Void)
    func paymentWithIdCurrency(id: String, _ completion: @escaping (Result<PaymentStatus, Error>) -> Void)
}

final class CartNetworkService {
    
    // MARK: - Properties
    
    private let client: NetworkClient
    
    // MARK: - Life Cycle
    
    init(client: NetworkClient = DefaultNetworkClient()) {
        self.client = client
    }
    
    private func fetchNftsIdInCart(_ completion: @escaping (Result<NftsInCart, Error>) -> Void) {
        let request = GetOrdersRequest()
        client.send(request: request, type: NftsInCart.self) { result in
            switch result {
            case .success(let nftsInCart):
                completion(.success(nftsInCart))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    private func fetchCart(nftsInCart: NftsInCart, _ completion: @escaping (Result<[NftItem], Error>) -> Void) {
        var nftItems: [NftItem] = []
        let group = DispatchGroup()
        nftsInCart.nfts.forEach {
            group.enter()
            client.send(request: NftByIdRequest(id: $0), type: NftItem.self) { result in
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

extension CartNetworkService: CartNetworkServiceProtocol {
    
    func getCart(_ completion: @escaping (Result<[NftItem], Error>) -> Void) {
        fetchNftsIdInCart { [weak self] result in
            switch result {
            case .success(let nftsInCart):
                self?.fetchCart(nftsInCart: nftsInCart) { result in
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
    
    func updateCart(nftsInCart: NftsInCart, _ completion: @escaping (Error?) -> Void) {
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
    
    func getCurrencies(_ completion: @escaping (Result<[Currency], Error>) -> Void) {
        let request = GetCurrenciesRequest()
        client.send(request: request, type: [Currency].self) { result in
            switch result {
            case .success(let currencies):
                DispatchQueue.main.async {
                    completion(.success(currencies))
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
    }
    
    func paymentWithIdCurrency(id: String, _ completion: @escaping (Result<PaymentStatus, Error>) -> Void) {
        let request = PaymentWithIdCurrencyRequest(id: id)
        client.send(request: request, type: PaymentStatus.self) { result in
            switch result {
            case .success(let paymentStatus):
                DispatchQueue.main.async {
                    completion(.success(paymentStatus))
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
    }
}
