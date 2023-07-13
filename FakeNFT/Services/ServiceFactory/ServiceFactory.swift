import Foundation

protocol ServiceFactoryProtocol {
    func makeAlertFactory() -> AlertFactoryProtocol
}

final class ServiceFactory: ServiceFactoryProtocol {
    func makeAlertFactory() -> AlertFactoryProtocol {
        AlertFactory()
    }
}
