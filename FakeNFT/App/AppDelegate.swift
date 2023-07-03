import UIKit

@main
final class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_: UIApplication, didFinishLaunchingWithOptions _: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        let serviceFactory: ServiceFactoryProtocol = ServiceFactory()
        let screenFactory: ScreenFactoryProtocol = ScreenFactory(serviceFactory: serviceFactory)
        let tabBarController = TabBarController(screenFactory: screenFactory)
        
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
        return true
    }
}
