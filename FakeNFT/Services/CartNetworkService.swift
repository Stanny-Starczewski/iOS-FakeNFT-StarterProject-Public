//
//  NetworkService.swift
//  FakeNFT
//
//  Created by Anton Vikhlyaev on 16.07.2023.
//

import Foundation

protocol CartNetworkServiceProtocol {
    func fetchCart(_ completion: @escaping (Result<[NftItem], Error>) -> Void)
}

final class CartNetworkService {
    
    // MARK: - Properties
    
    private let client: NetworkClient
    
    // MARK: - Life Cycle
    
    init(client: NetworkClient = DefaultNetworkClient()) {
        self.client = client
    }
    
    private func fetchNftIdsInOrder(_ completion: @escaping (Result<NftsInCart, Error>) -> Void) {
        let getOrdersRequest: GetOrdersRequest = GetOrdersRequest()
        
        client.send(request: getOrdersRequest, type: NftsInCart.self) { result in
            switch result {
            case .success(let nftsInCart):
                completion(.success(nftsInCart))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

// MARK: - NetworkServiceProtocol

extension CartNetworkService: CartNetworkServiceProtocol {
    
    func fetchCart(_ completion: @escaping (Result<[NftItem], Error>) -> Void) {
        fetchNftIdsInOrder { result in
            switch result {
            case .success(let nftIdsInCart):
                var nftItems: [NftItem] = []
                let group = DispatchGroup()
                nftIdsInCart.nfts.forEach { [weak self] id in
                    group.enter()
                    self?.client.send(request: NftByIdRequest(id: id), type: NftItem.self) { result in
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
            case .failure(let error):
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
    }
    
}
