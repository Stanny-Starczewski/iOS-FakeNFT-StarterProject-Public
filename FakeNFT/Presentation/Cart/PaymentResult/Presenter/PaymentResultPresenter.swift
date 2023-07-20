//
//  PaymentResultPresenter.swift
//  FakeNFT
//
//  Created by Anton Vikhlyaev on 14.07.2023.
//

import Foundation

protocol PaymentResultPresenterProtocol {
    func viewIsReady()
    func didTapSuccessResultButton()
    func didTapFailureResultButton()
}

protocol PaymentResultDelegate: AnyObject {
    func didTapTryAgain()
}

final class PaymentResultPresenter {
    
    // MARK: - Properties
    
    private weak var delegate: PaymentResultDelegate?
    
    private var isSuccess: Bool
    
    weak var view: PaymentResultViewProtocol?
    
    // MARK: - Life Cycle
    
    init(isSuccess: Bool, delegate: PaymentResultDelegate) {
        self.isSuccess = isSuccess
        self.delegate = delegate
    }
}

// MARK: - PaymentResultPresenterProtocol

extension PaymentResultPresenter: PaymentResultPresenterProtocol {
    func viewIsReady() {
        if isSuccess {
            view?.showSuccess()
        } else {
            view?.showFailure()
        }
    }
    
    func didTapSuccessResultButton() {
        view?.dismissViewControllers()
    }
    
    func didTapFailureResultButton() {
        delegate?.didTapTryAgain()
    }
}
