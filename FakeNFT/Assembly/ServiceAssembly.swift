//
//  ServiceAssembly.swift
//  FakeNFT
//
//  Created by Andrei Kashin on 24.07.2023.
//

import Foundation

protocol ServiceAssemblyProtocol {
    func makeNetworkService() -> NetworkServiceProtocol
    func makeCartSortService() -> CartSortServiceProtocol
}

final class ServiceAssembly: ServiceAssemblyProtocol {
    
    func makeNetworkService() -> NetworkServiceProtocol {
        NetworkService()
    }
    
    func makeCartSortService() -> CartSortServiceProtocol {
        CartSortService()
    }
    
}
