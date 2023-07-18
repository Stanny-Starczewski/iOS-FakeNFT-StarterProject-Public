//
//  PaymentResultViewController.swift
//  FakeNFT
//
//  Created by Anton Vikhlyaev on 14.07.2023.
//

import UIKit

protocol PaymentResultViewProtocol: AnyObject {
    
}

final class PaymentResultViewController: UIViewController {
    
    // MARK: - Constants
    
    private struct Constants {
        static let positiveResultImage = UIImage(named: "Tater")
        static let positiveResultLabelText = "Успех! Оплата прошла, поздравляем с покупкой!"
        static let positiveResultButtonText = "Вернуться в каталог"
        static let negativeResultImage = UIImage(named: "Zeus")
        static let negativeResultLabelText = "Упс! Что-то пошло не так :( Попробуйте ещё раз!"
        static let negativeResultButtonText = "Попробовать еще раз"
    }
    
    // MARK: - UI
    
    private lazy var positiveResultImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.isHidden = false
        imageView.image = Constants.positiveResultImage
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var positiveResultLabel: UILabel = {
        let label = UILabel()
        label.isHidden = false
        label.text = Constants.positiveResultLabelText
        label.font = .bold22
        label.textAlignment = .center
        label.textColor = .appBlack
        label.numberOfLines = 3
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var positiveResultButton: UIButton = {
        let button = UIButton(type: .system)
        button.isHidden = false
        button.setTitle(Constants.positiveResultButtonText, for: .normal)
        button.backgroundColor = .appBlack
        button.layer.cornerRadius = 16
        button.titleLabel?.font = .bold17
        button.tintColor = .appWhite
        button.addTarget(self, action: #selector(positiveResultButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var negativeResultImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.isHidden = false
        imageView.image = Constants.negativeResultImage
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var negativeResultLabel: UILabel = {
        let label = UILabel()
        label.isHidden = false
        label.text = Constants.negativeResultLabelText
        label.font = .bold22
        label.textAlignment = .center
        label.textColor = .appBlack
        label.numberOfLines = 3
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var negativeResultButton: UIButton = {
        let button = UIButton(type: .system)
        button.isHidden = false
        button.setTitle(Constants.negativeResultButtonText, for: .normal)
        button.backgroundColor = .appBlack
        button.layer.cornerRadius = 16
        button.titleLabel?.font = .bold17
        button.tintColor = .appWhite
        button.addTarget(self, action: #selector(negativeResultButtonTapped), for: .touchUpInside)
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
        setConstraints()
    }
    
    // MARK: - Setup UI
    
    private func setupView() {
        view.backgroundColor = .appWhite
        
        if presenter.isSuccessfulPayment {
            view.addSubview(positiveResultImageView)
            view.addSubview(positiveResultLabel)
            view.addSubview(positiveResultButton)
        } else {
            view.addSubview(negativeResultImageView)
            view.addSubview(negativeResultLabel)
            view.addSubview(negativeResultButton)
        }
    }
    
    // MARK: - Actions
    
    @objc
    private func positiveResultButtonTapped() {
        presenter.didTapPositiveResultButton()
    }
    
    @objc
    private func negativeResultButtonTapped() {
        presenter.didTapNegativeResultButton()
    }
}

// MARK: - PaymentResultViewProtocol

extension PaymentResultViewController: PaymentResultViewProtocol {
    
}

// MARK: - Setting Constraints

extension PaymentResultViewController {
    private func setConstraints() {
        if presenter.isSuccessfulPayment {
            NSLayoutConstraint.activate([
                positiveResultImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 196),
                positiveResultImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                positiveResultImageView.widthAnchor.constraint(equalToConstant: 278),
                positiveResultImageView.heightAnchor.constraint(equalToConstant: 278),
                
                positiveResultLabel.topAnchor.constraint(equalTo: positiveResultImageView.bottomAnchor, constant: 20),
                positiveResultLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 36),
                positiveResultLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -36),
                
                positiveResultButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
                positiveResultButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
                positiveResultButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
                positiveResultButton.heightAnchor.constraint(equalToConstant: 60)
            ])
        } else {
            NSLayoutConstraint.activate([
                negativeResultImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 196),
                negativeResultImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                negativeResultImageView.widthAnchor.constraint(equalToConstant: 287),
                negativeResultImageView.heightAnchor.constraint(equalToConstant: 287),
                
                negativeResultLabel.topAnchor.constraint(equalTo: negativeResultImageView.bottomAnchor, constant: 20),
                negativeResultLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 26),
                negativeResultLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -26),
                
                negativeResultButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
                negativeResultButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
                negativeResultButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
                negativeResultButton.heightAnchor.constraint(equalToConstant: 60)
            ])
        }
        
    }
}
