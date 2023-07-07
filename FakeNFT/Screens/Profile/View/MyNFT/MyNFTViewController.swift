//
//  MyNFTViewController.swift
//  FakeNFT
//
//  Created by Andrei Kashin on 07.07.2023.
//

import UIKit

final class MyNFTViewController: UIViewController {
    
    // MARK: - Properties
    
    var presenter: MyNFTPresenter?
    
    private var nftImage: [String] = Array(0..<3).map{ "\($0)" }
    private var nftName: [String] = [ "Lilo", "Spring", "April"]
    private var nftPrice: [String] = [ "1,78 ETH", "1,99 ETH", "2,99 ETH" ]
    private var nftRating: [Int] = [ 3, 4, 5 ]
    
    private var nftIDs = true
    
    //MARK: - Layout elements
    
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
        emptyLabel.font = UIFont.boldSystemFont(ofSize: 17)
        emptyLabel.textColor = .appBlack
        return emptyLabel
    }()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    // MARK: - Actions
    
    @objc
    private func didTapBackButton() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc
    private func didTapSortButton() {
   
    }
    
    // MARK: - Methods
    
    private func setupNavBar(emptyNFTs: Bool) {
        navigationController?.navigationBar.tintColor = .appBlack
        navigationItem.leftBarButtonItem = backButton
        if !emptyNFTs {
            navigationItem.rightBarButtonItem = filterButton
            navigationItem.title = "Мои NFT"
        }
    }
    
    private func setupView() {
        if nftIDs == true {
            setupNavBar(emptyNFTs: false)
            addMainView()
        } else {
            setupNavBar(emptyNFTs: true)
            addEmptyView()
        }
    }
    
    private func addMainView() {
        view.backgroundColor = .appWhite
        
        view.addSubview(myNFTTable)
        
        NSLayoutConstraint.activate([
            
            myNFTTable.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            myNFTTable.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            myNFTTable.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            myNFTTable.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -39)
            
        ])
    }
    
    private func addEmptyView() {
        
        view.backgroundColor = .appWhite
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
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: MyNFTCell.reuseIdentifier)  as! MyNFTCell
        
        let image = UIImage(named: nftImage[indexPath.row])
        cell.myNFTImage.image = image
        cell.myNFTRating.setStarsRating(rating: nftRating[indexPath.row])
        cell.myNFTNameLabel.text = nftName[indexPath.row]
        cell.myNFTPriceValueLabel.text = nftPrice[indexPath.row]
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
}

// MARK: - UITableViewDelegate

extension MyNFTViewController: UITableViewDelegate {}
