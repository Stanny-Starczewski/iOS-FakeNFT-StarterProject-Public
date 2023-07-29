//
//  alertBuilder.swift
//  FakeNFT
//
//  Created by Anton Vikhlyaev on 14.07.2023.
//

import UIKit

protocol AlertBuilderProtocol {
    func makeSortingAlert(
        priceAction: @escaping () -> Void,
        ratingAction: @escaping () -> Void,
        nameAction: @escaping () -> Void
    ) -> UIAlertController
    
    func makeErrorAlert(
        with message: String
    ) -> UIAlertController
    
    func makeErrorAlertWithRepeatAction(
        with message: String,
        _ handler: @escaping () -> Void
    ) -> UIAlertController
}

final class AlertBuilder: AlertBuilderProtocol {
    
    // MARK: - Constants
    
    private struct Constants {
        static let sortingAlertTitle = Localization.sortingAlertTitle
        static let sortingAlertAtPriceText = Localization.sortingAlertByPriceText
        static let sortingAlertAtRatingText = Localization.sortingAlertByRatingText
        static let sortingAlertAtNameText = Localization.sortingAlertByNameText
        static let sortingAlertCloseText = Localization.sortingAlertCloseText
        static let errorAlertTitle = Localization.errorAlertTitle
        static let errorAlertRepeatTitle = Localization.errorAlertRepeatTitle
        static let errorAlertOkAction = Localization.errorAlertOkAction
        static let errorAlertCancelAction = Localization.errorAlertCancelAction
        static let errorAlertRepeatAction = Localization.errorAlertRepeatAction
    }
    
    // MARK: - Methods
    
    func makeSortingAlert(
        priceAction: @escaping () -> Void,
        ratingAction: @escaping () -> Void,
        nameAction: @escaping () -> Void
    ) -> UIAlertController {
        let sortAlert = UIAlertController(
            title: Constants.sortingAlertTitle,
            message: nil,
            preferredStyle: .actionSheet
        )
        let atPriceAction = UIAlertAction(
            title: Constants.sortingAlertAtPriceText,
            style: .default
        ) { _ in
            priceAction()
        }
        let atRatingAction = UIAlertAction(
            title: Constants.sortingAlertAtRatingText,
            style: .default
        ) { _ in
            ratingAction()
        }
        let atNameAction = UIAlertAction(
            title: Constants.sortingAlertAtNameText,
            style: .default
        ) { _ in
            nameAction()
        }
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
            title: Constants.errorAlertTitle,
            message: message,
            preferredStyle: .alert
        )
        let okAction = UIAlertAction(title: Constants.errorAlertOkAction, style: .cancel)
        errorAlert.addAction(okAction)
        return errorAlert
    }
    
    func makeErrorAlertWithRepeatAction(
        with message: String,
        _ handler: @escaping () -> Void
    ) -> UIAlertController {
        let repeatAlert = UIAlertController(
            title: Constants.errorAlertRepeatTitle,
            message: message,
            preferredStyle: .alert
        )
        let cancelAction = UIAlertAction(
            title: Constants.errorAlertCancelAction,
            style: .cancel
        )
        let repeatAction = UIAlertAction(
            title: Constants.errorAlertRepeatAction,
            style: .default
        ) { _ in
            handler()
        }
        repeatAlert.addAction(cancelAction)
        repeatAlert.addAction(repeatAction)
        return repeatAlert
    }
}
