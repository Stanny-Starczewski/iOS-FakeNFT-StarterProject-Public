//
//  CartViewController.swift
//  FakeNFT
//
//  Created by Anton Vikhlyaev on 14.07.2023.
//

import UIKit

protocol CartViewProtocol: AnyObject {
    func updateUI()
    func showViewController(_ vc: UIViewController)
    func showEmptyCart()
    func showProgressHUB()
    func dismissProgressHUB()
}

final class CartViewController: UIViewController {
    
    // MARK: - Constants
    
    private struct Constants {
        static let bottomViewCornerRadius: CGFloat = 12
        static let iconSort = UIImage(named: "icon-sort")
        static let paymentButtonText = "К оплате"
        static let emptyCartLabelText = "Корзина пуста"
    }
    
    // MARK: - UI
    
    private lazy var emptyCartLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.emptyCartLabelText
        label.textAlignment = .center
        label.textColor = Image.appBlack.color
        label.font = .bold17
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.backgroundColor = Image.appWhite.color
        tableView.separatorStyle = .none
        tableView.contentInset = UIEdgeInsets(
            top: 20,
            left: 0,
            bottom: 20,
            right: 0
        )
        tableView.register(CartItemCell.self)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private lazy var bottomView: UIView = {
        let view = UIView()
        view.backgroundColor = Image.appLightGrey.color
        view.layer.cornerRadius = Constants.bottomViewCornerRadius
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var quantityLabel: UILabel = {
        let label = UILabel()
        label.text = "0 NFT"
        label.font = .regular15
        label.textColor = Image.appBlack.color
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var amountLabel: UILabel = {
        let label = UILabel()
        label.text = "0 ETH"
        label.font = .bold17
        label.textColor = Image.customGreen.color
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var totalStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [quantityLabel, amountLabel])
        stackView.axis = .vertical
        stackView.spacing = 2
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var paymentButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = Image.appBlack.color
        button.layer.cornerRadius = 16
        button.setTitle(Constants.paymentButtonText, for: .normal)
        button.titleLabel?.font = .bold17
        button.tintColor = Image.appWhite.color
        button.addTarget(self, action: #selector(paymentButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var bottomStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [totalStackView, paymentButton])
        stackView.axis = .horizontal
        stackView.spacing = 24
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    // MARK: - Properties
    
    private let presenter: CartPresenterProtocol
    
    // MARK: - Life Cycle
    
    init(presenter: CartPresenterProtocol) {
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
        setupNavigationController()
        presenter.viewIsReady()
    }
    
    // MARK: - Setup UI
    
    private func setupView() {
        view.backgroundColor = Image.appWhite.color
        view.addSubview(emptyCartLabel)
        view.addSubview(tableView)
        view.addSubview(bottomView)
        bottomView.addSubview(bottomStackView)
    }
    
    private func setupNavigationController() {
        let sortButton = UIBarButtonItem(
            image: Constants.iconSort,
            style: .plain,
            target: self,
            action: #selector(sortButtonTapped)
        )
        navigationItem.rightBarButtonItem = sortButton
        navigationController?.navigationBar.tintColor = Image.appBlack.color
    }
    
    private func setDelegates() {
        tableView.dataSource = self
    }
    
    // MARK: - Actions
    
    @objc
    private func sortButtonTapped() {
        presenter.didTapSortButton()
    }
    
    @objc
    private func paymentButtonTapped() {
        presenter.didTapPaymentButton()
    }
}

// MARK: - CartViewProtocol

extension CartViewController: CartViewProtocol {
    func showEmptyCart() {
        bottomView.isHidden = true
        tableView.isHidden = true
        emptyCartLabel.isHidden = false
        navigationItem.rightBarButtonItem = nil
    }
    
    func updateUI() {
        tableView.reloadSections(IndexSet(integer: 0), with: .automatic)
        quantityLabel.text = "\(presenter.count) NFT"
        amountLabel.text = String(format: "%.2f ETH", presenter.amount)
    }
    
    func showViewController(_ vc: UIViewController) {
        present(vc, animated: true)
    }
    
    func showProgressHUB() {
        UIBlockingProgressHUD.show()
    }
    
    func dismissProgressHUB() {
        UIBlockingProgressHUD.dismiss()
    }
}

// MARK: - CartItemCellDelegate

extension CartViewController: CartItemCellDelegate {
    func didDeleteItemButtonTapped(at indexPath: IndexPath) {
        presenter.didTapDeleteItem(at: indexPath)
    }
}

// MARK: - UITableViewDataSource

extension CartViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.numberOfRowsInSection(section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = presenter.cellForRow(at: indexPath)
        cell.delegate = self
        cell.currentIndexPath = indexPath
        return cell
    }
}

// MARK: - Setting Constraints

extension CartViewController {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            emptyCartLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            emptyCartLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            emptyCartLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomView.topAnchor),
            
            bottomView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bottomView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bottomView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0),
            
            bottomStackView.topAnchor.constraint(equalTo: bottomView.topAnchor, constant: 16),
            bottomStackView.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor, constant: 16),
            bottomStackView.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor, constant: -16),
            bottomStackView.bottomAnchor.constraint(equalTo: bottomView.bottomAnchor, constant: -16)
        ])
    }
}
