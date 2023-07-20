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
    func viewIsReady()
    func getCurrency(at indexPath: IndexPath) -> Currency
    func didSelectItem(at indexPath: IndexPath)
    func didTapAgreementLinkLabel()
    func didTapPaymentButton()
}

final class PaymentMethodsPresenter {
    
    // MARK: - Properties
    
    weak var view: PaymentMethodsViewProtocol?
    
    private let networkService: CartNetworkServiceProtocol
    
    private let screenAssembly: ScreenAssemblyProtocol
    
    private var selectedCurrency: Currency?
    
    private var repaymentAttempts = 1
    
    // MARK: - Data Store
    
    private lazy var currencies: [Currency] = []
    
    // MARK: - Life Cycle
    
    init(networkService: CartNetworkServiceProtocol, screenAssembly: ScreenAssemblyProtocol) {
        self.networkService = networkService
        self.screenAssembly = screenAssembly
    }
}

// MARK: - PaymentMethodsPresenterProtocol

extension PaymentMethodsPresenter: PaymentMethodsPresenterProtocol {
    var numberOfItemsInSection: Int {
        currencies.count
    }
    
    func viewIsReady() {
        UIBlockingProgressHUD.show()
        networkService.getCurrencies { [weak self] result in
            switch result {
            case .success(let currencies):
                self?.currencies = currencies
                self?.view?.updateUI()
                UIBlockingProgressHUD.dismiss()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func getCurrency(at indexPath: IndexPath) -> Currency {
        currencies[indexPath.item]
    }
    
    func didSelectItem(at indexPath: IndexPath) {
        selectedCurrency = currencies[indexPath.item]
    }
    
    func didTapAgreementLinkLabel() {
        guard let url = URL(string: Config.userAgreementUrl) else { return }
        let safariViewController = SFSafariViewController(url: url)
        view?.showViewController(safariViewController)
    }
    
    func didTapPaymentButton() {
        guard let selectedCurrency else { return }
        networkService.paymentWithIdCurrency(
            id: selectedCurrency.id
        ) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let paymentStatus):
                let isSuccess = paymentStatus.success
                let paymentResultViewController = self.screenAssembly.makePaymentResultScreen(isSuccess: isSuccess, delegate: self)
                paymentResultViewController.modalPresentationStyle = .fullScreen
                view?.showViewController(paymentResultViewController)
            case .failure(let error):
                print(error)
            }
        }
    }
}

// MARK: - PaymentResultDelegate

extension PaymentMethodsPresenter: PaymentResultDelegate {
    func didTapTryAgain() {
        if repaymentAttempts > 0 {
            didTapPaymentButton()
            repaymentAttempts -= 1
        } else {
            print("OVER")
        }
    }
}
