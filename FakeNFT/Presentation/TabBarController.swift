import UIKit

final class TabBarController: UITabBarController {
    
    private enum Tabs {
        case profile
        case catalog
        case cart
        case stats
        
        var image: UIImage {
            switch self {
            case .profile:
                return Image.iconProfile.image
            case .catalog:
                return Image.iconCatalog.image
            case .cart:
                return Image.iconCart.image
            case .stats:
                return Image.iconStats.image
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
    
    private let screenAssembly: ScreenAssemblyProtocol
    
    // MARK: - Life Cycle
    
    init(screenAssembly: ScreenAssemblyProtocol) {
        self.screenAssembly = screenAssembly
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
        let appearance = UITabBarAppearance()
        appearance.backgroundColor = Image.appWhite.color
        appearance.shadowColor = Image.appWhite.color
        appearance.stackedLayoutAppearance.selected.iconColor = Image.customBlue.color
        appearance.stackedLayoutAppearance.selected.titleTextAttributes = [NSAttributedString.Key.foregroundColor: Image.customBlue.color]
        tabBar.standardAppearance = appearance
        tabBar.unselectedItemTintColor = Image.appBlack.color
        tabBar.tintColor = Image.appBlack.color
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
                let profileScreen = screenAssembly.makeProfileScreen()
                return wrapInNavigationController(profileScreen)
            case .catalog:
                let catalogScreen = screenAssembly.makeCatalogScreen()
                return wrapInNavigationController(catalogScreen)
            case .cart:
                let cartScreen = screenAssembly.makeCartScreen()
                return wrapInNavigationController(cartScreen)
            case .stats:
                let statsScreen = screenAssembly.makeStatsScreen()
                return wrapInNavigationController(statsScreen)
            }
        }
        
        viewControllers?.enumerated().forEach {
            $1.tabBarItem.title = dataSource[$0].title
            $1.tabBarItem.image = dataSource[$0].image
            $1.tabBarItem.tag = $0
        }
    }
    
    private func wrapInNavigationController(_ vc: UIViewController) -> UINavigationController {
        UINavigationController(rootViewController: vc)
    }
}
