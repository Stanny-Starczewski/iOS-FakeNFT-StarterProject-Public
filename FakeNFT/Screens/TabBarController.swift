import UIKit

final class TabBarController: UITabBarController {
    
    private enum Tabs {
        case profile
        case catalog
        case cart
        case stats
        
        var iconName: String {
            switch self {
            case .profile:
                return "person.crop.circle.fill"
            case .catalog:
                return "rectangle.stack.fill"
            case .cart:
                return "bag.fill"
            case .stats:
                return "flag.2.crossed.fill"
            }
        }
        
        var title: String {
            switch self {
            case .profile:
                return "Профиль"
            case .catalog:
                return "Каталог"
            case .cart:
                return "Корзина"
            case .stats:
                return "Статистика"
            }
        }
    }
    
    private let screenFactory: ScreenFactoryProtocol
    
    // MARK: - Life Cycle
    
    init(screenFactory: ScreenFactoryProtocol) {
        self.screenFactory = screenFactory
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
        setupTabItems()
    }
    
    // MARK: - Setup UI
    
    private func setupTabBar() {
        tabBar.backgroundColor = .appWhite
        tabBar.barTintColor = .appWhite
        tabBar.unselectedItemTintColor = .appBlack
    }
    
    private func setupTabItems() {
        let dataSource: [Tabs] = [
            .profile,
            .catalog,
            .cart,
            .stats
        ]
        
        viewControllers = dataSource.map {
            switch $0 {
            case .profile:
                let profileScreen = screenFactory.makeProfileScreen()
                return wrapInNavigationController(profileScreen)
            case .catalog:
                let catalogScreen = screenFactory.makeCatalogScreen()
                return wrapInNavigationController(catalogScreen)
            case .cart:
                let cartScreen = screenFactory.makeCartScreen()
                return wrapInNavigationController(cartScreen)
            case .stats:
                let statsScreen = screenFactory.makeStatsScreen()
                return wrapInNavigationController(statsScreen)
            }
        }
        
        viewControllers?.enumerated().forEach {
            $1.tabBarItem.title = dataSource[$0].title
            $1.tabBarItem.image = UIImage(systemName: dataSource[$0].iconName)
            $1.tabBarItem.tag = $0
        }
    }
    
    private func wrapInNavigationController(_ vc: UIViewController) -> UINavigationController {
        UINavigationController(rootViewController: vc)
    }
}
