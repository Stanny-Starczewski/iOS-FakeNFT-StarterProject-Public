import Foundation

protocol CartPresenterProtocol {
    func didSortButtonTapped()
    func didDeleteItemTapped()
    func didPaymentButtonTapped()
}

final class CartPresenter {
    weak var view: CartViewProtocol?
    
    private let alertFactory: AlertFactoryProtocol
    
    private let screenFactory: ScreenFactoryProtocol
    
    init(alertFactory: AlertFactoryProtocol, screenFactory: ScreenFactoryProtocol) {
        self.alertFactory = alertFactory
        self.screenFactory = screenFactory
    }
}

// MARK: - CartPresenterProtocol

extension CartPresenter: CartPresenterProtocol {
    func didSortButtonTapped() {
        let sortAlert = alertFactory.makeSortingAlert()
        view?.showViewController(sortAlert)
    }
    
    func didDeleteItemTapped() {
        let removeItemViewController = screenFactory.makeRemoveItemScreen(with: nil)
        removeItemViewController.modalPresentationStyle = .fullScreen
        view?.showViewController(removeItemViewController)
    }
    
    func didPaymentButtonTapped() {
        let paymentMethodsViewController = screenFactory.makePaymentMethodsScreen()
        paymentMethodsViewController.modalPresentationStyle = .fullScreen
        view?.showViewController(paymentMethodsViewController)
    }
}
