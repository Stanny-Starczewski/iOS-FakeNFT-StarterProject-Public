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
    func didSortButtonTapped()
    func didDeleteItemTapped()
    func didPaymentButtonTapped()
}

final class CartPresenter {
    
    // MARK: - Properties
    
    weak var view: CartViewProtocol?
    
    // MARK: - Services
    
    private let alertFactory: AlertFactoryProtocol
    
    private let screenFactory: ScreenFactoryProtocol
    
    // MARK: - Data Store
    
    private lazy var cart: [NFTItem] = []
    
    // MARK: - Life Cycle
    
    init(alertFactory: AlertFactoryProtocol, screenFactory: ScreenFactoryProtocol) {
        self.alertFactory = alertFactory
        self.screenFactory = screenFactory
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
    
    func didSortButtonTapped() {
        let sortAlert = alertFactory.makeSortingAlert()
        view?.showViewController(sortAlert)
    }
    
    func didDeleteItemTapped() {
        let removeItemViewController = screenFactory.makeRemoveItemScreen(with: nil)
        removeItemViewController.modalPresentationStyle = .overFullScreen
        view?.showViewController(removeItemViewController)
    }
    
    func didPaymentButtonTapped() {
        let paymentMethodsViewController = screenFactory.makePaymentMethodsScreen()
        paymentMethodsViewController.modalPresentationStyle = .fullScreen
        view?.showViewController(paymentMethodsViewController)
    }
}
