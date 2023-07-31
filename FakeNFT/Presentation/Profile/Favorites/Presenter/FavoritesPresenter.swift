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
    func cellForItem(at indexPath: IndexPath) -> Item
    func didTapDeleteItem(at indexPath: IndexPath)
}

protocol FavoritesDelegate: AnyObject {
    func didDeleteItem(at id: String)
}

final class FavoritesPresenter: FavoritesPresenterProtocol {
    
    // MARK: - Properties
    
    var view: FavoritesViewControllerProtocol?
    
    private let alertBuilder: AlertBuilderProtocol
    private let screenAssembly: ScreenAssemblyProtocol
    private let networkService: NetworkServiceProtocol
    private weak var delegate: FavoritesDelegate?
    
    // MARK: - Data Store
    
    private lazy var nftItems: [Item] = []
    
    // MARK: - Init
    
    init(
        alertBuilder: AlertBuilderProtocol,
        screenAssembly: ScreenAssemblyProtocol,
        networkService: NetworkServiceProtocol,
        delegate: FavoritesDelegate
    ) {
        self.alertBuilder = alertBuilder
        self.screenAssembly = screenAssembly
        self.networkService = networkService
        self.delegate = delegate
    }
    
    // MARK: - Methods
    
    func numberOfRowsInSection(_ section: Int) -> Int {
        nftItems.count
    }
    
    func cellForItem(at indexPath: IndexPath) -> Item {
        
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
                let alert = self.alertBuilder.makeErrorAlert(with: error.localizedDescription)
                self.view?.showViewController(alert)
            }
        }
    }
    
    func didTapDeleteItem(at indexPath: IndexPath) {
        let deletedItem = nftItems[indexPath.item]
        delegate?.didDeleteItem(at: deletedItem.id)
        nftItems.remove(at: indexPath.item)
        if nftItems.isEmpty {
            view?.showEmptyCart()
        } else {
            view?.updateUI()
        }
    }
}
