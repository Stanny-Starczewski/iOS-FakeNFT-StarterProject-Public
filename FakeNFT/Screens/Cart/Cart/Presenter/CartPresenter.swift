import Foundation

protocol CartPresenterProtocol {
    func didSortButton()
    func didDeleteItem()
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
    func didSortButton() {
        let sortAlert = alertFactory.makeSortingAlert()
        view?.showViewController(sortAlert)
    }
    
    func didDeleteItem() {
        let removeItemViewController = screenFactory.makeRemoveItemScreen(with: nil)
        removeItemViewController.modalPresentationStyle = .fullScreen
        view?.showViewController(removeItemViewController)
    }
}
