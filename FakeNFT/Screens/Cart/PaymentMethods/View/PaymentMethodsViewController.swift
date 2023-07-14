//
//  PaymentMethodsViewController.swift
//  FakeNFT
//
//  Created by Anton Vikhlyaev on 14.07.2023.
//

import UIKit

protocol PaymentMethodsViewProtocol: AnyObject {
    
}

final class PaymentMethodsViewController: UIViewController {
    
    // MARK: - Constants
    
    private struct Constants {
        static let bottomViewCornerRadius: CGFloat = 12
        static let backButtonImage = UIImage(named: "icon-back")
        static let titleLabelText = "Выберите способ оплаты"
        static let paymentButtonText = "Оплатить"
        static let descriptionLabelText = "Совершая покупку, вы соглашаетесь с условиями"
        static let agreementLinkLabelText = "Пользовательского соглашения"
    }
    
    // MARK: - Properties
    
    private let presenter: PaymentMethodsPresenterProtocol
    
    // MARK: - UI
    
    private lazy var backButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(Constants.backButtonImage, for: .normal)
        button.tintColor = .appBlack
        button.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.titleLabelText
        label.textAlignment = .center
        label.textColor = .appBlack
        label.font = .bold17
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.bounces = false
        collectionView.allowsMultipleSelection = false
        collectionView.backgroundColor = .appWhite
        collectionView.register(PaymentMethodsCell.self, forCellWithReuseIdentifier: PaymentMethodsCell.reuseIdentifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    private lazy var bottomView: UIView = {
        let view = UIView()
        view.backgroundColor = .appLightGrey
        view.layer.cornerRadius = Constants.bottomViewCornerRadius
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.descriptionLabelText
        label.font = .regular13
        label.textColor = .appBlack
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var agreementLinkLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.agreementLinkLabelText
        label.font = .regular13
        label.textColor = .customBlue
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var paymentButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .appBlack
        button.layer.cornerRadius = 16
        button.setTitle(Constants.paymentButtonText, for: .normal)
        button.titleLabel?.font = .bold17
        button.tintColor = .appWhite
        button.addTarget(self, action: #selector(paymentButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: - Life Cycle
    
    init(presenter: PaymentMethodsPresenterProtocol) {
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
        setDelegates()
    }
    
    // MARK: - Setup UI
    
    private func setupView() {
        view.backgroundColor = .appWhite
        view.addSubview(backButton)
        view.addSubview(titleLabel)
        view.addSubview(collectionView)
        view.addSubview(bottomView)
        bottomView.addSubview(descriptionLabel)
        bottomView.addSubview(agreementLinkLabel)
        bottomView.addSubview(paymentButton)
    }
    
    private func setDelegates() {
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    // MARK: - Actions
    
    @objc
    private func backButtonTapped() {
        dismiss(animated: true)
    }
    
    @objc
    private func paymentButtonTapped() {
        print(#function)
    }
}

// MARK: - PaymentMethodsViewProtocol

extension PaymentMethodsViewController: PaymentMethodsViewProtocol {
    
}

// MARK: - UICollectionViewDataSource

extension PaymentMethodsViewController: UICollectionViewDataSource {
    
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        presenter.numberOfItemsInSection
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: PaymentMethodsCell.reuseIdentifier,
                for: indexPath
            ) as? PaymentMethodsCell
        else { return UICollectionViewCell() }
        cell.configure(with: presenter.getCurrency(at: indexPath))
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension PaymentMethodsViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        CGSize(width: (collectionView.frame.width / 2) - 7, height: 46)
    }
}

// MARK: - UICollectionViewDelegate

extension PaymentMethodsViewController: UICollectionViewDelegate {
 
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard
            let cell = collectionView.cellForItem(at: indexPath) as? PaymentMethodsCell
        else { return }
        cell.setSelected(true)
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        guard
            let cell = collectionView.cellForItem(at: indexPath) as? PaymentMethodsCell
        else { return }
        cell.setSelected(false)
    }
    
}

// MARK: - Setting Constraints

extension PaymentMethodsViewController {
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 9),
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 9),
            backButton.widthAnchor.constraint(equalToConstant: 24),
            backButton.heightAnchor.constraint(equalToConstant: 24),
            
            titleLabel.centerYAnchor.constraint(equalTo: backButton.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: backButton.trailingAnchor, constant: 24),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -57),
            
            collectionView.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: 29),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            collectionView.bottomAnchor.constraint(equalTo: bottomView.topAnchor, constant: -16),
            
            bottomView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bottomView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bottomView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            bottomView.heightAnchor.constraint(equalToConstant: 186),
            
            descriptionLabel.topAnchor.constraint(equalTo: bottomView.topAnchor, constant: 16),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            agreementLinkLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 4),
            agreementLinkLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            agreementLinkLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            paymentButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            paymentButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            paymentButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            paymentButton.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
}
