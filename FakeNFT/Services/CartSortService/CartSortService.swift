//
//  CartSortService.swift
//  FakeNFT
//
//  Created by Anton Vikhlyaev on 22.07.2023.
//

import Foundation

protocol CartSortServiceProtocol {
    func saveSortType(_ type: CartSortType)
    func loadSortType() -> CartSortType
}

final class CartSortService: CartSortServiceProtocol {
    
    private let key = String(describing: CartSortService.self)
    
    func saveSortType(_ type: CartSortType) {
        UserDefaults.standard.set(type.rawValue, forKey: key)
    }
    
    func loadSortType() -> CartSortType {
        CartSortType(rawValue: UserDefaults.standard.integer(forKey: key)) ?? .byName
    }

}
