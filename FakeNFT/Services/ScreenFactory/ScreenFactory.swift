import UIKit

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
    
    func makeStatsScreen() -> UIViewController {
        let presenter = StatsPresenter()
        let vc = StatsViewController(presenter: presenter)
        presenter.view = vc
        return vc
    }
}
