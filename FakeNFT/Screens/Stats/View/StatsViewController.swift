import UIKit

final class StatsViewController: UINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .appWhite
        navigationBar.tintColor = .appWhite

        let rootController = StatPageViewController()
        pushViewController(rootController, animated: false)
    }
}

