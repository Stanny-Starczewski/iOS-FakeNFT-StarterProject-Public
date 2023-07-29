//
//  ScreenAssembly.swift
//  FakeNFT
//
//  Created by Anton Vikhlyaev on 14.07.2023.
//

import UIKit

protocol ScreenAssemblyProtocol {
    func makeProfileScreen() -> UIViewController
    func makeEditProfileScreen(profile: Profile, delegate: EditProfileDelegate) -> UIViewController
    func makeMyNFTScreen() -> UIViewController
    func makeFavoritesScreen(delegate: FavoritesDelegate) -> UIViewController
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
    
    private let alertBuilder: AlertBuilderProtocol
    
    // MARK: - Life Cycle
    
    init(serviceAssembly: ServiceAssemblyProtocol, alertBuilder: AlertBuilderProtocol) {
        self.serviceAssembly = serviceAssembly
        self.alertBuilder = alertBuilder
    }
    
}

// MARK: - ScreenAssemblyProtocol

extension ScreenAssembly: ScreenAssemblyProtocol {
    func makeProfileScreen() -> UIViewController {
        let presenter = ProfilePresenter(screenAssembly: self)
        let vc = ProfileViewController(presenter: presenter)
        presenter.view = vc
        return vc
    }
    
    func makeEditProfileScreen(profile: Profile, delegate: EditProfileDelegate) -> UIViewController {
        let view = EditProfileViewController()
        let presenter = EditProfilePresenter(view: view, profile: profile, delegate: delegate)
        view.presenter = presenter
        return view
    }
    
    func makeMyNFTScreen() -> UIViewController {
        let presenter = MyNFTPresenter(
            alertBuilder: alertBuilder,
            screenAssembly: self,
            networkService: serviceAssembly.makeNetworkService(),
            cartSortService: serviceAssembly.makeCartSortService()
        )
        let vc = MyNFTViewController(presenter: presenter)
        presenter.view = vc
        return vc
    }
    
    func makeFavoritesScreen(delegate: FavoritesDelegate) -> UIViewController {
        let presenter = FavoritesPresenter(
            alertBuilder: alertBuilder,
            screenAssembly: self,
            networkService: serviceAssembly.makeNetworkService(),
            delegate: delegate
        )
        let vc = FavoritesViewController(presenter: presenter)
        presenter.view = vc
        return vc
    }
    
    func makeCatalogScreen() -> UIViewController {
        let vc = CatalogViewController(
            viewModel: CatalogueViewModel(
                provider: CatalogueDataProvider()
            )
        )
        return vc
    }
    
    func makeCartScreen() -> UIViewController {
        let presenter = CartPresenter(
            alertBuilder: alertBuilder,
            screenAssembly: self,
            networkService: serviceAssembly.makeNetworkService(),
            cartSortService: serviceAssembly.makeCartSortService()
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
            screenAssembly: self,
            alertBuilder: alertBuilder
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
        StatPageViewController()
    }
}
