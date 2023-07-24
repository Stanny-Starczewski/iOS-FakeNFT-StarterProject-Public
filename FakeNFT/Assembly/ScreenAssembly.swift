//
//  ScreenAssembly.swift
//  FakeNFT
//
//  Created by Andrei Kashin on 24.07.2023.
//

import UIKit

protocol ScreenAssemblyProtocol {
    func makeProfileScreen() -> UIViewController
    func makeEditProfileScreen(profile: Profile) -> UIViewController
    func makeCatalogScreen() -> UIViewController
    func makeCartScreen() -> UIViewController
//    func makeRemoveItemScreen(with item: NftItem, delegate: RemoveItemDelegate) -> UIViewController
//    func makePaymentMethodsScreen() -> UIViewController
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
    func makeEditProfileScreen(profile: Profile) -> UIViewController {
        let view = EditProfileViewController()
        let presenter = EditProfilePresenter(view: view, profile: profile)
        view.presenter = presenter
        return view
    }
    
    func makeProfileScreen() -> UIViewController {
        let presenter = ProfilePresenter()
        let vc = ProfileViewController(presenter: presenter)
        presenter.view = vc
        return vc
    }
    
//    func makeEditProfileScreen() -> UIViewController {
//        let presenter = EditProfilePresenter(view: view, profileData: Profile)
//        let vc = EditProfileViewController(presenter: presenter)
//        presenter.view = vc
//        return vc
//    }
    
    func makeCatalogScreen() -> UIViewController {
        let presenter = CatalogPresenter()
        let vc = CatalogViewController(presenter: presenter)
        presenter.view = vc
        return vc
    }
    
    func makeCartScreen() -> UIViewController {
        let presenter = CartPresenter()
        let vc = CartViewController(presenter: presenter)
        presenter.view = vc
        return vc
    }
//
//    func makeRemoveItemScreen(with item: NftItem, delegate: RemoveItemDelegate) -> UIViewController {
//        let presenter = RemoveItemPresenter(item: item, delegate: delegate)
//        let vc = RemoveItemViewController(presenter: presenter)
//        presenter.view = vc
//        return vc
//    }
//
//    func makePaymentMethodsScreen() -> UIViewController {
//        let presenter = PaymentMethodsPresenter(
//            currencyService: FakeConvertService(),
//            screenAssembly: self
//        )
//        let vc = PaymentMethodsViewController(presenter: presenter)
//        presenter.view = vc
//        return vc
//    }
//
//    func makePaymentResultScreen() -> UIViewController {
//        let presenter = PaymentResultPresenter()
//        let vc = PaymentResultViewController(presenter: presenter)
//        presenter.view = vc
//        return vc
//    }
//
    func makeStatsScreen() -> UIViewController {
        let presenter = StatsPresenter()
        let vc = StatsViewController(presenter: presenter)
        presenter.view = vc
        return vc
    }
}
