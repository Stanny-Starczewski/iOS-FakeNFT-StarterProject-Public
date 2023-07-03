import UIKit

final class AlertFactory: AlertFactoryProtocol {
    func makeSortingAlert() -> UIAlertController {
        let sortAlert = UIAlertController(
            title: "Сортировка",
            message: nil,
            preferredStyle: .actionSheet
        )
        let atPriceAction = UIAlertAction(
            title: "По цене",
            style: .default
        )
        let atRatingAction = UIAlertAction(
            title: "По рейтингу",
            style: .default
        )
        let atNameAction = UIAlertAction(
            title: "По названию",
            style: .default
        )
        let closeAction = UIAlertAction(
            title: "Закрыть",
            style: .cancel
        )
        sortAlert.addAction(atPriceAction)
        sortAlert.addAction(atRatingAction)
        sortAlert.addAction(atNameAction)
        sortAlert.addAction(closeAction)
        return sortAlert
    }
}
