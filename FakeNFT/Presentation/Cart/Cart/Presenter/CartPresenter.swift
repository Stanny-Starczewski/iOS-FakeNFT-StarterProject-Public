//
//  CartPresenter.swift
//  FakeNFT
//
//  Created by Anton Vikhlyaev on 14.07.2023.
//

import Foundation

protocol CartPresenterProtocol {
    var isEmptyCart: Bool { get }
    var count: Int { get }
    var amount: Double { get }
    func viewIsReady()
    func numberOfRowsInSection(_ section: Int) -> Int
    func cellForRow(at indexPath: IndexPath) -> CartItemCell
    func didTapSortButton()
    func didTapDeleteItem(at indexPath: IndexPath)
    func didTapPaymentButton()
}

final class CartPresenter {
    
    // MARK: - Properties
    
    weak var view: CartViewProtocol?
    
    // MARK: - Services
    
    private let alertBuilder: AlertBuilderProtocol
    private let screenAssembly: ScreenAssemblyProtocol
    private let networkService: NetworkServiceProtocol
    private let cartSortService: CartSortServiceProtocol
    
    // MARK: - Data Store
    
    private lazy var nftItems: [Item] = []
    
    // MARK: - Life Cycle
    
    init(
        alertBuilder: AlertBuilderProtocol,
        screenAssembly: ScreenAssemblyProtocol,
        networkService: NetworkServiceProtocol,
        cartSortService: CartSortServiceProtocol
    ) {
        self.alertBuilder = alertBuilder
        self.screenAssembly = screenAssembly
        self.networkService = networkService
        self.cartSortService = cartSortService
    }
    
    // MARK: - Methods
    
    private func updateCart() {
        let nftInCart = Order(nfts: nftItems.map { $0.id })
        networkService.updateCart(nftsInCart: nftInCart) { [weak self] error in
            guard let self else { return }
            if let error {
                let alert = self.alertBuilder.makeErrorAlert(with: error.localizedDescription)
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
}

// MARK: - CartPresenterProtocol

extension CartPresenter: CartPresenterProtocol {
    var isEmptyCart: Bool {
        nftItems.isEmpty
    }
    
    var count: Int {
        nftItems.count
    }
    
    var amount: Double {
        nftItems.reduce(0) { $0 + $1.price }
    }
    
    func viewIsReady() {
        view?.showProgressHUB()
        networkService.getCart { [weak self] result in
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
                let alert = self.alertBuilder.makeErrorAlert(with: error.localizedDescription)
                self.view?.showViewController(alert)
            }
        }
    }
    
    func numberOfRowsInSection(_ section: Int) -> Int {
        nftItems.count
    }
    
    func cellForRow(at indexPath: IndexPath) -> CartItemCell {
        let cell = CartItemCell()
        cell.configure(with: nftItems[indexPath.row])
        return cell
    }
    
    func didTapSortButton() {
        let sortAlert = alertBuilder.makeSortingAlert { [weak self] in
            self?.sortByPrice()
        } ratingAction: { [weak self] in
            self?.sortByRating()
        } nameAction: { [weak self] in
            self?.sortByName()
        }

        view?.showViewController(sortAlert)
    }
    
    func didTapDeleteItem(at indexPath: IndexPath) {
        let nftItem = nftItems[indexPath.row]
        let removeItemViewController = screenAssembly.makeRemoveItemScreen(with: nftItem, delegate: self)
        removeItemViewController.modalPresentationStyle = .overFullScreen
        view?.showViewController(removeItemViewController)
    }
    
    func didTapPaymentButton() {
        let paymentMethodsViewController = screenAssembly.makePaymentMethodsScreen()
        paymentMethodsViewController.modalPresentationStyle = .fullScreen
        view?.showViewController(paymentMethodsViewController)
    }
}

// MARK: - RemoveItemDelegate

extension CartPresenter: RemoveItemDelegate {
    func didDeleteItem(_ item: Item) {
        guard let deletedItemIndex = nftItems.firstIndex(of: item) else { return }
        nftItems.remove(at: deletedItemIndex)
        updateCart()
        view?.updateUI()
    }
}

// MARK: - SortType

enum CartSortType: Int {
    case byName
    case byPrice
    case byRating
}
