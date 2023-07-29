//
//  MyNFTViewController.swift
//  FakeNFT
//
//  Created by Andrei Kashin on 07.07.2023.
//

import UIKit
import Kingfisher

protocol MyNFTViewControllerProtocol: AnyObject {
    func updateUI()
    func showViewController(_ vc: UIViewController)
    func showEmptyCart()
    func showNoInternetView()
    func showProgressHUB()
    func dismissProgressHUB()
}

final class MyNFTViewController: UIViewController, MyNFTViewControllerProtocol {
    
    // MARK: - Properties
    
    private var presenter: MyNFTPresenterProtocol
    
    // MARK: - Layout elements
    
    private lazy var backButton = UIBarButtonItem(
        image: UIImage(named: "Backward"),
        style: .plain,
        target: self,
        action: #selector(didTapBackButton)
    )
    
    private lazy var filterButton = UIBarButtonItem(
        image: UIImage(named: "Filter"),
        style: .plain,
        target: self,
        action: #selector(didTapSortButton)
    )
    
    private lazy var myNFTTable: UITableView = {
        let myNFTTable = UITableView()
        myNFTTable.translatesAutoresizingMaskIntoConstraints = false
        myNFTTable.register(MyNFTCell.self, forCellReuseIdentifier: MyNFTCell.reuseIdentifier)
        myNFTTable.backgroundColor = Image.appWhite.color
        myNFTTable.dataSource = self
        myNFTTable.delegate = self
        myNFTTable.separatorStyle = .none
        myNFTTable.allowsMultipleSelection = false
        myNFTTable.isUserInteractionEnabled = true
        return myNFTTable
    }()
    
    private lazy var emptyLabel: UILabel = {
        let emptyLabel = UILabel()
        emptyLabel.translatesAutoresizingMaskIntoConstraints = false
        emptyLabel.text = "У Вас ещё нет NFT"
        emptyLabel.font = .bold17
        emptyLabel.textColor = Image.appBlack.color
        return emptyLabel
    }()
    
    // MARK: - Init
    
    init(presenter: MyNFTPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavBar()
        addMainView()
        presenter.viewIsReady()
        
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
    
    // MARK: - Methods
    
    func updateUI() {
        myNFTTable.reloadSections(IndexSet(integer: 0), with: .automatic)
    }
    
    func showProgressHUB() {
        UIBlockingProgressHUD.show()
    }
    
    func dismissProgressHUB() {
        UIBlockingProgressHUD.dismiss()
    }
    
    func showViewController(_ vc: UIViewController) {
        present(vc, animated: true)
    }
    
    func showEmptyCart() {
        myNFTTable.isHidden = true
        emptyLabel.isHidden = false
        navigationItem.rightBarButtonItem = nil
        navigationItem.title = ""
    }
    
    func showNoInternetView() {
        navigationController?.pushViewController(NoInternetViewController(), animated: true)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    private func setupNavBar() {
        navigationController?.navigationBar.tintColor = Image.appBlack.color
        navigationItem.leftBarButtonItem = backButton
        navigationItem.rightBarButtonItem = filterButton
        navigationItem.title = "Мои NFT"
    }
    
    private func addMainView() {
        view.backgroundColor = Image.appWhite.color
        
        view.addSubview(myNFTTable)
        
        NSLayoutConstraint.activate([
            
            myNFTTable.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            myNFTTable.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            myNFTTable.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            myNFTTable.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            
        ])
    }
    
    private func addEmptyView() {
        
        view.backgroundColor = Image.appWhite.color
        view.addSubview(emptyLabel)
        
        NSLayoutConstraint.activate([
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
