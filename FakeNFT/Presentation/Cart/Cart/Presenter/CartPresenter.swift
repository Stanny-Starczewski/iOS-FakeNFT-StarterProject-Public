//
//  CartPresenter.swift
//  FakeNFT
//
//  Created by Anton Vikhlyaev on 14.07.2023.
//

import Foundation

protocol CartPresenterProtocol {
    var isEmptyCart: Bool { get }
    func numberOfRowsInSection(_ section: Int) -> Int
    func cellForRow(at indexPath: IndexPath) -> CartItemCell
    func didTapSortButton()
    func didTapDeleteItem()
    func didTapPaymentButton()
}

final class CartPresenter {
    
    // MARK: - Properties
    
    weak var view: CartViewProtocol?
    
    // MARK: - Services
    
    private let alertAssembly: AlertAssemblyProtocol
    
    private let screenAssembly: ScreenAssemblyProtocol
    
    // MARK: - Data Store
    
    private lazy var cart: [NftItem] = []
    
    // MARK: - Life Cycle
    
    init(alertAssembly: AlertAssemblyProtocol, screenAssembly: ScreenAssemblyProtocol) {
        self.alertAssembly = alertAssembly
        self.screenAssembly = screenAssembly
    }
}

// MARK: - CartPresenterProtocol

extension CartPresenter: CartPresenterProtocol {
    
    var isEmptyCart: Bool {
//        cart.isEmpty
        false
    }
    
    func numberOfRowsInSection(_ section: Int) -> Int {
//        cart.count
        3
    }
    
    func cellForRow(at indexPath: IndexPath) -> CartItemCell {
        let cell = CartItemCell()
//        cell.configure(with: cart[indexPath.row])
        return cell
    }
    
    func didTapSortButton() {
        let sortAlert = alertAssembly.makeSortingAlert()
        view?.showViewController(sortAlert)
    }
    
    func didTapDeleteItem() {
        let removeItemViewController = screenAssembly.makeRemoveItemScreen(with: nil)
        removeItemViewController.modalPresentationStyle = .overFullScreen
        view?.showViewController(removeItemViewController)
    }
    
    func didTapPaymentButton() {
        let paymentMethodsViewController = screenAssembly.makePaymentMethodsScreen()
        paymentMethodsViewController.modalPresentationStyle = .fullScreen
        view?.showViewController(paymentMethodsViewController)
    }
}
