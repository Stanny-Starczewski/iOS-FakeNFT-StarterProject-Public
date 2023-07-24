//
//  ServiceAssembly.swift
//  FakeNFT
//
//  Created by Andrei Kashin on 24.07.2023.
//

import Foundation

protocol ServiceAssemblyProtocol {
    func makeNetworkService() -> CartNetworkServiceProtocol
}

final class ServiceAssembly: ServiceAssemblyProtocol {
    
    func makeNetworkService() -> CartNetworkServiceProtocol {
        CartNetworkService()
    }
    
}
