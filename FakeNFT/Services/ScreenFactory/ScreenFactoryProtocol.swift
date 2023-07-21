import UIKit

protocol ScreenFactoryProtocol {
    func makeProfileScreen() -> UIViewController
    func makeCatalogScreen() -> UIViewController
    func makeCartScreen() -> UIViewController
    func makeStatsScreen() -> UIViewController
 //   func makeMyNFTScreen() -> UIViewController
}
