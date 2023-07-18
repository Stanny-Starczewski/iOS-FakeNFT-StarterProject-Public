//
//  PaymentResultPresenter.swift
//  FakeNFT
//
//  Created by Anton Vikhlyaev on 14.07.2023.
//

import Foundation

protocol PaymentResultPresenterProtocol {
    var isSuccessfulPayment: Bool { get }
    func didTapPositiveResultButton()
    func didTapNegativeResultButton()
}

final class PaymentResultPresenter {
    
    // MARK: - Properties
    
    weak var view: PaymentResultViewProtocol?
    
}

// MARK: - PaymentResultPresenterProtocol

extension PaymentResultPresenter: PaymentResultPresenterProtocol {
    
    var isSuccessfulPayment: Bool {
        false
    }
    
    func didTapPositiveResultButton() {
        print(#function)
    }
    
    func didTapNegativeResultButton() {
        print(#function)
    }
}
