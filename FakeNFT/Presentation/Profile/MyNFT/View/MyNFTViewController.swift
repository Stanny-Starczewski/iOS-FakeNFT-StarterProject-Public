//
//  MyNFTViewController.swift
//  FakeNFT
//
//  Created by Andrei Kashin on 07.07.2023.
//

import UIKit

protocol MyNFTViewProtocol: AnyObject {
    func updateUI()
    func showViewController(_ vc: UIViewController)
    func showEmptyCart()
    func showNoInternetView()
    func showProgressHUB()
    func dismissProgressHUB()
}

final class MyNFTViewController: UIViewController {
    
    // MARK: - Constants
    
    private enum Constants {
        static let emptyLabelText = Localization.profileEmptyMyNFTLabelText
        static let navigationBarTitleText = Localization.profileMyNFTTitleText
    }
    
    // MARK: - UI
    
    private lazy var backButton = UIBarButtonItem(
        image: Image.iconBack.image,
        style: .plain,
        target: self,
        action: #selector(didTapBackButton)
    )
    
    private lazy var sortButton = UIBarButtonItem(
        image: Image.iconSort.image,
        style: .plain,
        target: self,
        action: #selector(didTapSortButton)
    )
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(MyNFTCell.self)
        tableView.backgroundColor = Image.appWhite.color
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.allowsMultipleSelection = false
        tableView.isUserInteractionEnabled = true
        return tableView
    }()
    
    private lazy var emptyLabel: UILabel = {
        let emptyLabel = UILabel()
        emptyLabel.translatesAutoresizingMaskIntoConstraints = false
        emptyLabel.text = Constants.emptyLabelText
        emptyLabel.font = .bold17
        emptyLabel.textColor = Image.appBlack.color
        emptyLabel.isHidden = true
        return emptyLabel
    }()
    
    // MARK: - Properties
    
    private var presenter: MyNFTPresenterProtocol
    
    // MARK: - Life Cycle
    
    init(presenter: MyNFTPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationController()
        setupView()
        setConstraints()
        presenter.viewIsReady()
    }
    
    // MARK: - Setup UI
    
    private func setupNavigationController() {
        navigationController?.navigationBar.tintColor = Image.appBlack.color
        navigationItem.leftBarButtonItem = backButton
        navigationItem.rightBarButtonItem = sortButton
        navigationItem.title = Constants.navigationBarTitleText
    }
    
    private func setupView() {
        view.backgroundColor = Image.appWhite.color
        view.addSubview(tableView)
        view.addSubview(emptyLabel)
    }
    
    // MARK: - Actions
    
    @objc
    private func didTapBackButton() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc
    private func didTapSortButton() {
        presenter.didTapSortButton()
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            emptyLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            emptyLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
}

// MARK: - UITableViewDataSource

extension MyNFTViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.numberOfRowsInSection(section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.deselectRow(at: indexPath, animated: true)
        let cell = presenter.cellForRow(at: indexPath)
        cell.currentIndexPath = indexPath
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
}

// MARK: - UITableViewDelegate

extension MyNFTViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - MyNFTViewControllerProtocol

extension MyNFTViewController: MyNFTViewProtocol {
    func updateUI() {
        tableView.reloadSections(
            IndexSet(integer: 0), with: .automatic
        )
    }
    
    func showViewController(_ vc: UIViewController) {
        present(vc, animated: true)
    }
    
    func showEmptyCart() {
        tableView.isHidden = true
        emptyLabel.isHidden = false
        navigationItem.rightBarButtonItem = nil
        navigationItem.title = nil
    }
    
    func showNoInternetView() {
        let noInternetViewController = NoInternetViewController()
        navigationController?.pushViewController(noInternetViewController, animated: true)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    func showProgressHUB() {
        UIBlockingProgressHUD.show()
    }
    
    func dismissProgressHUB() {
        UIBlockingProgressHUD.dismiss()
    }
}
