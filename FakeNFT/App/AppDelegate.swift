import UIKit

@main
final class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_: UIApplication, didFinishLaunchingWithOptions _: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        let serviceAssembly: ServiceAssemblyProtocol = ServiceAssembly()
        let screenAssembly: ScreenAssemblyProtocol = ScreenAssembly(serviceAssembly: serviceAssembly)
        let tabBarController = TabBarController(screenAssembly: screenAssembly)
        
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
        return true
    }
}
