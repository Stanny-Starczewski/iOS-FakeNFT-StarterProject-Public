//
//  FavoritesPresenter.swift
//  FakeNFT
//
//  Created by Andrei Kashin on 25.07.2023.
//

import Foundation

protocol FavoritesPresenterProtocol: AnyObject {
    func viewIsReady()
    func numberOfRowsInSection(_ section: Int) -> Int
    func cellForItem(at indexPath: IndexPath) -> NFTNetworkModel
}

final class FavoritesPresenter: FavoritesPresenterProtocol {
    
    // MARK: - Properties
    
    var view: FavoritesViewControllerProtocol?
    
    private let alertAssembly: AlertAssemblyProtocol
    private let screenAssembly: ScreenAssemblyProtocol
    private let networkService: NetworkServiceProtocol
    
    // MARK: - Data Store
    
    private lazy var nftItems: [NFTNetworkModel] = []
    
    // MARK: - Init
    
    init(
        alertAssembly: AlertAssemblyProtocol,
        screenAssembly: ScreenAssemblyProtocol,
        networkService: NetworkServiceProtocol
    ) {
        self.alertAssembly = alertAssembly
        self.screenAssembly = screenAssembly
        self.networkService = networkService
    }
    
    // MARK: - Methods
    
    func numberOfRowsInSection(_ section: Int) -> Int {
        nftItems.count
    }
    
    func cellForItem(at indexPath: IndexPath) -> NFTNetworkModel {
        
        nftItems[indexPath.item]
        
    }
    
    func viewIsReady() {
        view?.showProgressHUB()
        networkService.getFavorites { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let nftItems):
                view?.dismissProgressHUB()
                self.nftItems = nftItems
                if nftItems.isEmpty {
                    view?.showEmptyCart()
                } else {
                    view?.updateUI()
                }
            case .failure(let error):
                view?.dismissProgressHUB()
                let alert = self.alertAssembly.makeErrorAlert(with: error.localizedDescription)
                self.view?.showViewController(alert)
            }
        }
    }
}
