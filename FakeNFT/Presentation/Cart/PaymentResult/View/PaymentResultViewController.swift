//
//  PaymentResultViewController.swift
//  FakeNFT
//
//  Created by Anton Vikhlyaev on 14.07.2023.
//

import UIKit

protocol PaymentResultViewProtocol: AnyObject {
    func showSuccess()
    func showFailure()
    func dismissViewControllers()
}

final class PaymentResultViewController: UIViewController {
    
    // MARK: - Constants
    
    private struct Constants {
        static let successImage = UIImage(named: "cart-result-image-success")
        static let successLabelText = "Успех! Оплата прошла, поздравляем с покупкой!"
        static let successButtonText = "Вернуться в каталог"
        static let failureImage = UIImage(named: "cart-result-image-failure")
        static let failureLabelText = "Упс! Что-то пошло не так :( Попробуйте ещё раз!"
        static let failureButtonText = "Попробовать еще раз"
    }
    
    // MARK: - UI
    
    private lazy var successResultImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.isHidden = false
        imageView.image = Constants.successImage
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var successResultLabel: UILabel = {
        let label = UILabel()
        label.isHidden = false
        label.text = Constants.successLabelText
        label.font = .bold22
        label.textAlignment = .center
        label.textColor = .appBlack
        label.numberOfLines = 3
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var successResultButton: UIButton = {
        let button = UIButton(type: .system)
        button.isHidden = false
        button.setTitle(Constants.successButtonText, for: .normal)
        button.backgroundColor = .appBlack
        button.layer.cornerRadius = 16
        button.titleLabel?.font = .bold17
        button.tintColor = .appWhite
        button.addTarget(self, action: #selector(successResultButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var failureResultImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.isHidden = false
        imageView.image = Constants.failureImage
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var failureResultLabel: UILabel = {
        let label = UILabel()
        label.isHidden = false
        label.text = Constants.failureLabelText
        label.font = .bold22
        label.textAlignment = .center
        label.textColor = .appBlack
        label.numberOfLines = 3
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var failureResultButton: UIButton = {
        let button = UIButton(type: .system)
        button.isHidden = false
        button.setTitle(Constants.failureButtonText, for: .normal)
        button.backgroundColor = .appBlack
        button.layer.cornerRadius = 16
        button.titleLabel?.font = .bold17
        button.tintColor = .appWhite
        button.addTarget(self, action: #selector(failureResultButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: - Properties
    
    private let presenter: PaymentResultPresenterProtocol
    
    // MARK: - Life Cycle
    
    init(presenter: PaymentResultPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        presenter.viewIsReady()
    }
    
    // MARK: - Setup UI
    
    private func setupView() {
        view.backgroundColor = .appWhite
    }
    
    // MARK: - Actions
    
    @objc
    private func successResultButtonTapped() {
        presenter.didTapSuccessResultButton()
    }
    
    @objc
    private func failureResultButtonTapped() {
        dismiss(animated: true)
        presenter.didTapFailureResultButton()
    }
}

// MARK: - PaymentResultViewProtocol

extension PaymentResultViewController: PaymentResultViewProtocol {
    func showSuccess() {
        view.addSubview(successResultImageView)
        view.addSubview(successResultLabel)
        view.addSubview(successResultButton)
        
        NSLayoutConstraint.activate([
            successResultImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 196),
            successResultImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            successResultImageView.widthAnchor.constraint(equalToConstant: 278),
            successResultImageView.heightAnchor.constraint(equalToConstant: 278),
            
            successResultLabel.topAnchor.constraint(equalTo: successResultImageView.bottomAnchor, constant: 20),
            successResultLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 36),
            successResultLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -36),
            
            successResultButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            successResultButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            successResultButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            successResultButton.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    func showFailure() {
        view.addSubview(failureResultImageView)
        view.addSubview(failureResultLabel)
        view.addSubview(failureResultButton)
        
        NSLayoutConstraint.activate([
            failureResultImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 196),
            failureResultImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            failureResultImageView.widthAnchor.constraint(equalToConstant: 287),
            failureResultImageView.heightAnchor.constraint(equalToConstant: 287),
            
            failureResultLabel.topAnchor.constraint(equalTo: failureResultImageView.bottomAnchor, constant: 20),
            failureResultLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 26),
            failureResultLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -26),
            
            failureResultButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            failureResultButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            failureResultButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            failureResultButton.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    func dismissViewControllers() {
        let tabBarController = view.window?.rootViewController as? TabBarController
        tabBarController?.selectedIndex = 1
        view.window?.rootViewController?.dismiss(animated: true)
    }
}
