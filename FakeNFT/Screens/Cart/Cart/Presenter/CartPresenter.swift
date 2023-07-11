import Foundation

protocol CartPresenterProtocol {
    func didSortButtonTapped()
}

final class CartPresenter {
    weak var view: CartViewProtocol?
    
    private let alertFactory: AlertFactoryProtocol
    
    init(alertFactory: AlertFactoryProtocol) {
        self.alertFactory = alertFactory
    }
}

// MARK: - CartPresenterProtocol

extension CartPresenter: CartPresenterProtocol {
    func didSortButtonTapped() {
        let sortAlert = alertFactory.makeSortingAlert()
        view?.showViewController(sortAlert)
    }
}
