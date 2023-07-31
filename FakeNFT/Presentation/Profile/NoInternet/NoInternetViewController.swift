//
//  NoInternetViewController.swift
//  FakeNFT
//
//  Created by Andrei Kashin on 09.07.2023.
//

import UIKit

final class NoInternetViewController: UIViewController {
    
    // MARK: - Layout elements
    
    private lazy var noInternetLabel: UILabel = {
        let noInternetLabel = UILabel()
        noInternetLabel.translatesAutoresizingMaskIntoConstraints = false
        noInternetLabel.text = "Нет интернета"
        noInternetLabel.font = .bold17
        noInternetLabel.textColor = Image.appBlack.color
        return noInternetLabel
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setConstraints()
    }
    
    // MARK: - Layout methods
    
    private func setupView() {
        view.backgroundColor = Image.appWhite.color
        view.addSubview(noInternetLabel)
    }
    
    private func setConstraints() {
        
        NSLayoutConstraint.activate([
            noInternetLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            noInternetLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
}
