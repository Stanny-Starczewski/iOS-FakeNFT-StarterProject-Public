//
//  AlertAssembly.swift
//  FakeNFT
//
//  Created by Andrei Kashin on 24.07.2023.
//

import UIKit

protocol AlertAssemblyProtocol {
    func makeSortingAlert() -> UIAlertController
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
}

