//
//  ServiceAssembly.swift
//  FakeNFT
//
//  Created by Anton Vikhlyaev on 14.07.2023.
//

import Foundation

protocol ServiceAssemblyProtocol {
    func makeAlertAssembly() -> AlertAssemblyProtocol
}

final class ServiceAssembly: ServiceAssemblyProtocol {
    func makeAlertAssembly() -> AlertAssemblyProtocol {
        AlertAssembly()
    }
}
