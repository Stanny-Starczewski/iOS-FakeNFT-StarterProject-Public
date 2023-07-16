//
//  ServiceFactory.swift
//  FakeNFT
//
//  Created by Anton Vikhlyaev on 14.07.2023.
//

import Foundation

protocol ServiceFactoryProtocol {
    func makeAlertFactory() -> AlertFactoryProtocol
}

final class ServiceFactory: ServiceFactoryProtocol {
    func makeAlertFactory() -> AlertFactoryProtocol {
        AlertFactory()
    }
}
