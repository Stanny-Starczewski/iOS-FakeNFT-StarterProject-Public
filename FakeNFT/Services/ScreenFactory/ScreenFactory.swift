//
//  ScreenFactory.swift
//  FakeNFT
//
//  Created by Anton Vikhlyaev on 14.07.2023.
//

import UIKit

protocol ScreenFactoryProtocol {
    func makeProfileScreen() -> UIViewController
    func makeCatalogScreen() -> UIViewController
    func makeCartScreen() -> UIViewController
    func makeRemoveItemScreen(with item: NFTItem?) -> UIViewController
    func makePaymentMethodsScreen() -> UIViewController
    func makeAgreementWebScreen() -> UIViewController
    func makeStatsScreen() -> UIViewController
}

final class ScreenFactory {
    private let serviceFactory: ServiceFactoryProtocol
    
    init(serviceFactory: ServiceFactoryProtocol) {
        self.serviceFactory = serviceFactory
    }
}

// MARK: - ScreenFactoryProtocol

extension ScreenFactory: ScreenFactoryProtocol {
    func makeProfileScreen() -> UIViewController {
        let presenter = ProfilePresenter()
        let vc = ProfileViewController(presenter: presenter)
        presenter.view = vc
        return vc
    }
    
    func makeCatalogScreen() -> UIViewController {
        let presenter = CatalogPresenter()
        let vc = CatalogViewController(presenter: presenter)
        presenter.view = vc
        return vc
    }
    
    func makeCartScreen() -> UIViewController {
        let presenter = CartPresenter(
            alertFactory: serviceFactory.makeAlertFactory(),
            screenFactory: self
        )
        let vc = CartViewController(presenter: presenter)
        presenter.view = vc
        return vc
    }
    
    func makeRemoveItemScreen(with item: NFTItem? = nil) -> UIViewController {
        let presenter = RemoveItemPresenter()
        let vc = RemoveItemViewController(presenter: presenter)
        presenter.view = vc
        return vc
    }
    
    func makePaymentMethodsScreen() -> UIViewController {
        let presenter = PaymentMethodsPresenter(
            currencyService: FakeConvertService(),
            screenFactory: self
        )
        let vc = PaymentMethodsViewController(presenter: presenter)
        presenter.view = vc
        return vc
    }
    
    func makePaymentResultScreen() -> UIViewController {
        let presenter = PaymentResultPresenter()
        let vc = PaymentResultViewController(presenter: presenter)
        presenter.view = vc
        return vc
    }
    
    func makeAgreementWebScreen() -> UIViewController {
        let presenter = AgreementWebPresenter()
        let vc = AgreementWebViewController(presenter: presenter)
        presenter.view = vc
        return vc
    }
    
    func makeStatsScreen() -> UIViewController {
        let presenter = StatsPresenter()
        let vc = StatsViewController(presenter: presenter)
        presenter.view = vc
        return vc
    }
}
