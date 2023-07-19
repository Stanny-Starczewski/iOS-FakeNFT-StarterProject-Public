//
//  ScreenAssembly.swift
//  FakeNFT
//
//  Created by Anton Vikhlyaev on 14.07.2023.
//

import UIKit

protocol ScreenAssemblyProtocol {
    func makeProfileScreen() -> UIViewController
    func makeCatalogScreen() -> UIViewController
    func makeCartScreen() -> UIViewController
    func makeRemoveItemScreen(with item: NftItem?) -> UIViewController
    func makePaymentMethodsScreen() -> UIViewController
    func makeStatsScreen() -> UIViewController
}

final class ScreenAssembly {
    
    // MARK: - Profirties
    
    private let serviceAssembly: ServiceAssemblyProtocol
    
    private let alertAssembly: AlertAssemblyProtocol
    
    // MARK: - Life Cycle
    
    init(serviceAssembly: ServiceAssemblyProtocol, alertAssembly: AlertAssemblyProtocol) {
        self.serviceAssembly = serviceAssembly
        self.alertAssembly = alertAssembly
    }
    
}

// MARK: - ScreenAssemblyProtocol

extension ScreenAssembly: ScreenAssemblyProtocol {
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
            alertAssembly: alertAssembly,
            screenAssembly: self,
            networkService: serviceAssembly.makeNetworkService()
        )
        let vc = CartViewController(presenter: presenter)
        presenter.view = vc
        return vc
    }
    
    func makeRemoveItemScreen(with item: NftItem? = nil) -> UIViewController {
        let presenter = RemoveItemPresenter()
        let vc = RemoveItemViewController(presenter: presenter)
        presenter.view = vc
        return vc
    }
    
    func makePaymentMethodsScreen() -> UIViewController {
        let presenter = PaymentMethodsPresenter(
            currencyService: FakeConvertService(),
            screenAssembly: self
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
    
    func makeStatsScreen() -> UIViewController {
        let presenter = StatsPresenter()
        let vc = StatsViewController(presenter: presenter)
        presenter.view = vc
        return vc
    }
}
