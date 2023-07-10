//
//  AboutViewController.swift
//  FakeNFT
//
//  Created by Andrei Kashin on 07.07.2023.
//

import UIKit

final class AboutViewController: UIViewController {
    
    //MARK: - Layout elements
    
    private lazy var backButton = UIBarButtonItem(
        image: UIImage(named: "Backward"),
        style: .plain,
        target: self,
        action: #selector(didTapBackButton)
    )
    
    private lazy var emptyLabel: UILabel = {
        let emptyLabel = UILabel()
        emptyLabel.translatesAutoresizingMaskIntoConstraints = false
        emptyLabel.text = "Здесь будет информация о разработчике"
        emptyLabel.font = UIFont.boldSystemFont(ofSize: 17)
        emptyLabel.textColor = .appBlack
        return emptyLabel
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavBar()
        setupView()
        setConstraints()
    }
    
    // MARK: - Actions
    
    @objc
    private func didTapBackButton() {
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Layout methods
    
    private func setupNavBar() {
        navigationController?.navigationBar.tintColor = .appBlack
        navigationItem.leftBarButtonItem = backButton
        navigationItem.title = "О разработчике"
    }
    
    private func setupView() {
        view.backgroundColor = .appWhite
        view.addSubview(emptyLabel)
    }
    
    private func setConstraints() {
        
        NSLayoutConstraint.activate([
            emptyLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            emptyLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
}

