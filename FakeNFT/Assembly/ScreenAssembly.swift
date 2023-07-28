//
//  ScreenAssembly.swift
//  FakeNFT
//
//  Created by Andrei Kashin on 24.07.2023.
//

import UIKit

protocol ScreenAssemblyProtocol {
    func makeProfileScreen() -> UIViewController
    func makeEditProfileScreen(profile: Profile, delegate: EditProfileDelegate) -> UIViewController
    func makeMyNFTScreen() -> UIViewController
    func makeFavoritesScreen(delegate: FavoritesDelegate) -> UIViewController
    func makeCatalogScreen() -> UIViewController
    func makeCartScreen() -> UIViewController
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
            alertAssembly: alertAssembly,
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
            alertAssembly: alertAssembly,
            screenAssembly: self,
            networkService: serviceAssembly.makeNetworkService(),
            delegate: delegate
        )
        let vc = FavoritesViewController(presenter: presenter)
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
        let presenter = CartPresenter()
        let vc = CartViewController(presenter: presenter)
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
