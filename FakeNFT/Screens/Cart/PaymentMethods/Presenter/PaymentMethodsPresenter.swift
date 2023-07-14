//
//  PaymentMethodsPresenter.swift
//  FakeNFT
//
//  Created by Anton Vikhlyaev on 14.07.2023.
//

import Foundation

protocol PaymentMethodsPresenterProtocol {
    var numberOfItemsInSection: Int { get }
    func getCurrency(at indexPath: IndexPath) -> Cryptocurrency
}

final class PaymentMethodsPresenter {
    
    // MARK: - Properties
    
    weak var view: PaymentMethodsViewProtocol?
    
    private let currencyService: CryptoConverterProtocol
    
    // MARK: - Data Store
    
    private lazy var currencies: [Cryptocurrency] = currencyService.getCryptocurrencies()
    
    // MARK: - Life Cycle
    
    init(currencyService: CryptoConverterProtocol) {
        self.currencyService = currencyService
    }
    
}

// MARK: - PaymentMethodsPresenterProtocol

extension PaymentMethodsPresenter: PaymentMethodsPresenterProtocol {
    
    var numberOfItemsInSection: Int {
        currencies.count
    }
    
    func getCurrency(at indexPath: IndexPath) -> Cryptocurrency {
        currencies[indexPath.item]
    }
    
}
