import Foundation

final class ServiceFactory: ServiceFactoryProtocol {
    func makeAlertFactory() -> AlertFactoryProtocol {
        AlertFactory()
    }
}
