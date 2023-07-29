//
//  MyNFTPresenter.swift
//  FakeNFT
//
//  Created by Andrei Kashin on 07.07.2023.
//

import Foundation

protocol MyNFTPresenterProtocol: AnyObject {
    func viewIsReady()
    func numberOfRowsInSection(_ section: Int) -> Int
    func cellForRow(at indexPath: IndexPath) -> MyNFTCell
    func didTapSortButton()
}

final class MyNFTPresenter {
    
    // MARK: - Properties
    
    weak var view: MyNFTViewControllerProtocol?
    
    private let alertAssembly: AlertAssemblyProtocol
    private let screenAssembly: ScreenAssemblyProtocol
    private let networkService: NetworkServiceProtocol
    private let cartSortService: CartSortServiceProtocol
    
    // MARK: - Data Store
    
    private lazy var nftItems: [NFTNetworkModel] = []
    
    // MARK: - Init
    
    init(
        alertAssembly: AlertAssemblyProtocol,
        screenAssembly: ScreenAssemblyProtocol,
        networkService: NetworkServiceProtocol,
        cartSortService: CartSortServiceProtocol
    ) {
        self.alertAssembly = alertAssembly
        self.screenAssembly = screenAssembly
        self.networkService = networkService
        self.cartSortService = cartSortService
    }
}

// MARK: - MyNFTPresenterProtocol

extension MyNFTPresenter: MyNFTPresenterProtocol {
    func viewIsReady() {
        view?.showProgressHUB()
        networkService.getMyNFT { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let nftItems):
                view?.dismissProgressHUB()
                self.nftItems = nftItems
                if nftItems.isEmpty {
                    view?.showEmptyCart()
                } else {
                    applySortType()
                }
            case .failure(let error):
                view?.dismissProgressHUB()
                let alert = self.alertAssembly.makeErrorAlert(with: error.localizedDescription)
                self.view?.showViewController(alert)
            }
        }
    }
    
    private func sortByPrice() {
        nftItems.sort { $0.price < $1.price }
        view?.updateUI()
        cartSortService.saveSortType(.byPrice)
    }
    
    private func sortByRating() {
        nftItems.sort { $0.rating < $1.rating }
        view?.updateUI()
        cartSortService.saveSortType(.byRating)
    }
    
    private func sortByName() {
        nftItems.sort { $0.name < $1.name }
        view?.updateUI()
        cartSortService.saveSortType(.byName)
    }
    
    private func applySortType() {
        switch cartSortService.loadSortType() {
        case .byPrice:
            sortByPrice()
        case .byRating:
            sortByRating()
        case .byName:
            sortByName()
        }
    }
    
    func numberOfRowsInSection(_ section: Int) -> Int {
        nftItems.count
    }
    
    func cellForRow(at indexPath: IndexPath) -> MyNFTCell {
        let cell = MyNFTCell()
        cell.configure(with: nftItems[indexPath.row])
        return cell
    }
    
    func didTapSortButton() {
        let sortAlert = alertAssembly.makeSortingAlert { [weak self] in
            self?.sortByPrice()
        } ratingAction: { [weak self] in
            self?.sortByRating()
        } nameAction: { [weak self] in
            self?.sortByName()
        }
        
        view?.showViewController(sortAlert)
    }
}
