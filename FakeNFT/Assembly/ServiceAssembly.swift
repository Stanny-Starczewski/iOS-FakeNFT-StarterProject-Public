//
//  ServiceAssembly.swift
//  FakeNFT
//
//  Created by Anton Vikhlyaev on 14.07.2023.
//

import Foundation

protocol ServiceAssemblyProtocol {
    func makeNetworkService() -> CartNetworkServiceProtocol
    func makeCartSortService() -> CartSortServiceProtocol
}

final class ServiceAssembly: ServiceAssemblyProtocol {
    
    func makeNetworkService() -> CartNetworkServiceProtocol {
        NetworkService()
    }
    
    func makeCartSortService() -> CartSortServiceProtocol {
        CartSortService()
    }
}
