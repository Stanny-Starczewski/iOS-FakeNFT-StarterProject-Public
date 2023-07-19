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
    
    private let alertAssembly: AlertAssemblyProtocol
    
    private let screenAssembly: ScreenAssemblyProtocol
    
    private let networkService: CartNetworkServiceProtocol
    
    // MARK: - Data Store
    
    private lazy var nftItems: [NftItem] = []
    
    // MARK: - Life Cycle
    
    init(
        alertAssembly: AlertAssemblyProtocol,
        screenAssembly: ScreenAssemblyProtocol,
        networkService: CartNetworkServiceProtocol
    ) {
        self.alertAssembly = alertAssembly
        self.screenAssembly = screenAssembly
        self.networkService = networkService
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
        UIBlockingProgressHUD.show()
        networkService.fetchCart { [weak self] result in
            switch result {
            case .success(let nftItems):
                self?.nftItems = nftItems
                self?.view?.updateUI()
                UIBlockingProgressHUD.dismiss()
            case .failure(let error):
                print(error)
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
        let sortAlert = alertAssembly.makeSortingAlert()
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
    func didDeleteItem(_ item: NftItem) {
        guard let deletedItemIndex = nftItems.firstIndex(of: item) else { return }
        nftItems.remove(at: deletedItemIndex)
        view?.updateUI()
    }
}
