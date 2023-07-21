//
//  MyNFTPresenter.swift
//  FakeNFT
//
//  Created by Andrei Kashin on 07.07.2023.
//

import Foundation

protocol MyNFTPresenterProtocol {
    var view: MyNFTViewControllerProtocol? { get set }
    func viewDidLoad()
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

struct NFTNetworkModelResult {
    let createdAt: String
    let name: String
    let images: [String]
    let rating: Int
    let description: String
    let price: Float
    let author: String
    let id: String
}

final class MyNFTPresenter {
    
    // MARK: - Properties
    
    let networkClient = DefaultNetworkClient()
    
    weak var view: MyNFTViewControllerProtocol?
    
    private(set) var myNFTs: [NFTNetworkModel]?
    
    private(set) var authors: [String: String] = [:]
    
    // MARK: - Methods
    
    func getMyNFTs(nftIDs: [String]) {
        var loadedNFTs: [NFTNetworkModel] = []
        
        nftIDs.forEach { id in
            networkClient.send(request: GetNFTByIdRequest(id: id), type: NFTNetworkModel.self) { [self] result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let nft):
                        loadedNFTs.append(nft)
                        if loadedNFTs.count == nftIDs.count {
                            self.getAuthors(nfts: loadedNFTs)
                            self.myNFTs? = loadedNFTs
                        }
                    case .failure:
                        self.view?.showNoInternetView()
                        UIBlockingProgressHUD.dismiss()
                    }
                }
            }
        }
    }
    
    func getAuthors(nfts: [NFTNetworkModel]) {
        var authorsSet: Set<String> = []
        nfts.forEach { nft in
            authorsSet.insert(nft.author)
        }
        let semaphore = DispatchSemaphore(value: 0)
        authorsSet.forEach { author in
            networkClient.send(request: GetAuthorByIdRequest(id: author), type: AuthorNetworkModel.self) { [self] result in
                switch result {
                case .success(let author):
                    authors.updateValue(author.name, forKey: author.id)
                    if authors.count == authorsSet.count { semaphore.signal() }
                case .failure(let error):
                    assertionFailure(error.localizedDescription)
                    return
                }
            }
        }
        semaphore.wait()
    }
}

// MARK: - MyNFTPresenterProtocol

extension MyNFTPresenter: MyNFTPresenterProtocol {
    
    func viewDidLoad() {
      //  getProfileData()
    }
    
}
