//
//  AboutViewController.swift
//  FakeNFT
//
//  Created by Andrei Kashin on 07.07.2023.
//

import UIKit

final class AboutViewController: UIViewController {
    
    // MARK: - Constants
    
    private enum Constants {
        static let aboutTitleText = Localization.profileAboutTitleText
        static let emptyLabelText = Localization.profileEmptyAboutLabelText
    }
    
    // MARK: - Layout elements
    
    private lazy var backButton = UIBarButtonItem(
        image: Image.iconBack.image,
        style: .plain,
        target: self,
        action: #selector(didTapBackButton)
    )
    
    private lazy var emptyLabel: UILabel = {
        let emptyLabel = UILabel()
        emptyLabel.translatesAutoresizingMaskIntoConstraints = false
        emptyLabel.text = Constants.emptyLabelText
        emptyLabel.font = .bold17
        emptyLabel.textColor = Image.appBlack.color
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
        navigationController?.navigationBar.tintColor = Image.appBlack.color
        navigationItem.leftBarButtonItem = backButton
        navigationItem.title = Constants.aboutTitleText
    }
    
    private func setupView() {
        view.backgroundColor = Image.appWhite.color
        view.addSubview(emptyLabel)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            emptyLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            emptyLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
}
