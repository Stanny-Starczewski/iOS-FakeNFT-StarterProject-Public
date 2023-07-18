//
//  PaymentMethodsPresenter.swift
//  FakeNFT
//
//  Created by Anton Vikhlyaev on 14.07.2023.
//

import Foundation
import SafariServices

protocol PaymentMethodsPresenterProtocol {
    var numberOfItemsInSection: Int { get }
    func getCurrency(at indexPath: IndexPath) -> Cryptocurrency
    func didTapAgreementLinkLabel()
}

final class PaymentMethodsPresenter {
    
    // MARK: - Properties
    
    weak var view: PaymentMethodsViewProtocol?
    
    private let currencyService: CryptoConverterProtocol
    
    private let screenAssembly: ScreenAssemblyProtocol
    
    // MARK: - Data Store
    
    private lazy var currencies: [Cryptocurrency] = currencyService.getCryptocurrencies()
    
    // MARK: - Life Cycle
    
    init(currencyService: CryptoConverterProtocol, screenAssembly: ScreenAssemblyProtocol) {
        self.currencyService = currencyService
        self.screenAssembly = screenAssembly
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
    
    func didTapAgreementLinkLabel() {
        guard let url = URL(string: Config.userAgreementUrl) else { return }
        let safariViewController = SFSafariViewController(url: url)
        view?.showViewController(safariViewController)
    }
}
