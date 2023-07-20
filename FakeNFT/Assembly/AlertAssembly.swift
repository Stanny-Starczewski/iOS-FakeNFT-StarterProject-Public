//
//  AlertAssembly.swift
//  FakeNFT
//
//  Created by Anton Vikhlyaev on 14.07.2023.
//

import UIKit

protocol AlertAssemblyProtocol {
    func makeSortingAlert() -> UIAlertController
    func makeErrorAlert(with message: String) -> UIAlertController
    func makeRepaymentAlert(with message: String, _ handler: @escaping () -> Void) -> UIAlertController
}

final class AlertAssembly: AlertAssemblyProtocol {
    
    // MARK: - Constants
    
    private struct Constants {
        static let sortingAlertTitle = "Сортировка"
        static let sortingAlertAtPriceText = "По цене"
        static let sortingAlertAtRatingText = "По рейтингу"
        static let sortingAlertAtNameText = "По названию"
        static let sortingAlertCloseText = "Закрыть"
    }
    
    // MARK: - Methods
    
    func makeSortingAlert() -> UIAlertController {
        let sortAlert = UIAlertController(
            title: Constants.sortingAlertTitle,
            message: nil,
            preferredStyle: .actionSheet
        )
        let atPriceAction = UIAlertAction(
            title: Constants.sortingAlertAtPriceText,
            style: .default
        )
        let atRatingAction = UIAlertAction(
            title: Constants.sortingAlertAtRatingText,
            style: .default
        )
        let atNameAction = UIAlertAction(
            title: Constants.sortingAlertAtNameText,
            style: .default
        )
        let closeAction = UIAlertAction(
            title: Constants.sortingAlertCloseText,
            style: .cancel
        )
        sortAlert.addAction(atPriceAction)
        sortAlert.addAction(atRatingAction)
        sortAlert.addAction(atNameAction)
        sortAlert.addAction(closeAction)
        return sortAlert
    }
    
    func makeErrorAlert(with message: String) -> UIAlertController {
        let errorAlert = UIAlertController(
            title: "Error",
            message: message,
            preferredStyle: .alert
        )
        let okAction = UIAlertAction(title: "OK", style: .cancel)
        errorAlert.addAction(okAction)
        return errorAlert
    }
    
    func makeRepaymentAlert(with message: String, _ handler: @escaping () -> Void) -> UIAlertController {
        let repaymentAlert = UIAlertController(
            title: "Error",
            message: message,
            preferredStyle: .alert
        )
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        let tryAgainAction = UIAlertAction(title: "Try Again", style: .default) { _ in
            handler()
        }
        repaymentAlert.addAction(cancelAction)
        repaymentAlert.addAction(tryAgainAction)
        return repaymentAlert
    }
}
