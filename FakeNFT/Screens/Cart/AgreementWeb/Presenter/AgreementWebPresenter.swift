//
//  AgreementWebPresenter.swift
//  FakeNFT
//
//  Created by Anton Vikhlyaev on 15.07.2023.
//

import Foundation

protocol AgreementWebPresenterProtocol {
    func viewIsReady()
    func didUpdateProgressValue(_ newValue: Double)
}

final class AgreementWebPresenter {
    
    // MARK: - Properties
    
    weak var view: AgreementWebViewProtocol?
    
    // MARK: - Methods
    
    private func shouldHideProgress(for value: Float) -> Bool {
        abs(value - 1.0) <= 0.0001
    }
}

// MARK: - AgreementWebPresenterProtocol

extension AgreementWebPresenter: AgreementWebPresenterProtocol {
    
    func viewIsReady() {
        guard let url = URL(string: Config.userAgreementUrl) else { return }
        let request = URLRequest(url: url)
        view?.load(on: request)
        didUpdateProgressValue(0)
    }
    
    func didUpdateProgressValue(_ newValue: Double) {
        let newProgressValue = Float(newValue)
        view?.setProgressValue(newProgressValue)
        
        let shouldHideProgress = shouldHideProgress(for: newProgressValue)
        view?.setProgressHidden(shouldHideProgress)
    }

}
