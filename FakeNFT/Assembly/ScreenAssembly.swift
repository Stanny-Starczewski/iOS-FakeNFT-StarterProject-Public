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
    func makeRemoveItemScreen(with item: NftItem, delegate: RemoveItemDelegate) -> UIViewController
    func makePaymentMethodsScreen() -> UIViewController
    func makePaymentResultScreen(isSuccess: Bool, delegate: PaymentResultDelegate) -> UIViewController
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
    
    func makeRemoveItemScreen(with item: NftItem, delegate: RemoveItemDelegate) -> UIViewController {
        let presenter = RemoveItemPresenter(item: item, delegate: delegate)
        let vc = RemoveItemViewController(presenter: presenter)
        presenter.view = vc
        return vc
    }
    
    func makePaymentMethodsScreen() -> UIViewController {
        let presenter = PaymentMethodsPresenter(
            networkService: serviceAssembly.makeNetworkService(),
            screenAssembly: self
        )
        let vc = PaymentMethodsViewController(presenter: presenter)
        presenter.view = vc
        return vc
    }
    
    func makePaymentResultScreen(isSuccess: Bool, delegate: PaymentResultDelegate) -> UIViewController {
        let presenter = PaymentResultPresenter(isSuccess: isSuccess, delegate: delegate)
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
