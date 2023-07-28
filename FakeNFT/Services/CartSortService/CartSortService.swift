//
//  CartSortService.swift
//  FakeNFT
//
//  Created by Andrei Kashin on 26.07.2023.
//

import Foundation

protocol CartSortServiceProtocol {
    func saveSortType(_ type: SortType)
    func loadSortType() -> SortType
}

final class CartSortService: CartSortServiceProtocol {
    
    private let key = String(describing: CartSortService.self)
    
    func saveSortType(_ type: SortType) {
        UserDefaults.standard.set(type.rawValue, forKey: key)
    }
    
    func loadSortType() -> SortType {
        SortType(rawValue: UserDefaults.standard.integer(forKey: key)) ?? .byName
    }
}
