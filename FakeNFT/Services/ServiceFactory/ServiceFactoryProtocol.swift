import Foundation

protocol ServiceFactoryProtocol {
    func makeAlertFactory() -> AlertFactoryProtocol
}
