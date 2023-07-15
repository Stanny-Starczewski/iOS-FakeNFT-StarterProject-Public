//
//  PaymentResultPresenter.swift
//  FakeNFT
//
//  Created by Anton Vikhlyaev on 14.07.2023.
//

import Foundation

protocol PaymentResultPresenterProtocol {
    var isSuccessfulPayment: Bool { get }
    func didPositiveResultButtonTapped()
    func didNegativeResultButtonTapped()
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
    
    func didPositiveResultButtonTapped() {
        print(#function)
    }
    
    func didNegativeResultButtonTapped() {
        print(#function)
    }
}
