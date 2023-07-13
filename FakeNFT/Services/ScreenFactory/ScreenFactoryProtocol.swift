import UIKit

protocol ScreenFactoryProtocol {
    func makeProfileScreen() -> UIViewController
    func makeCatalogScreen() -> UIViewController
    func makeCartScreen() -> UIViewController
    func makeRemoveItemScreen(with item: NFTItem?) -> UIViewController
    func makeStatsScreen() -> UIViewController
}
