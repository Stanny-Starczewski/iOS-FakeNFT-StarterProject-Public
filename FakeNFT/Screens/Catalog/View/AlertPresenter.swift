import UIKit

protocol AlertPresenterProtocol {
    func preparingDataAndDisplay(alertText: String)
    func preparingAlertWithRepeat(alertText: String, handler: @escaping () -> Void )
}

protocol AlertPresenterDelegate: AnyObject {
    func showAlert(alert: UIAlertController)
}

struct AlertPresenter: AlertPresenterProtocol {
    weak var delegate: AlertPresenterDelegate?
    
    func preparingDataAndDisplay(alertText: String) {
        let alert = UIAlertController(title: Names.errorMessageTitle,
                                      message: alertText,
                                      preferredStyle: .alert)
        let alertAction = UIAlertAction(title: Names.errorAlertOk, style: .default)
        
        alert.addAction(alertAction)
        delegate?.showAlert(alert: alert)
    }
    
    func preparingAlertWithRepeat(alertText: String, handler: @escaping () -> Void ) {
        let alert = UIAlertController(title: Names.errorMessageTitleRepeat,
                                      message: alertText,
                                      preferredStyle: .alert)
        let alertAction = UIAlertAction(title: Names.errorAlertOk, style: .default)
        let alertRepeatAction = UIAlertAction(title: Names.errorAlertRepeat, style: .default) { _ in
            handler()
        }
        
        alert.addAction(alertAction)
        alert.addAction(alertRepeatAction)
        
        delegate?.showAlert(alert: alert)
    }
}
