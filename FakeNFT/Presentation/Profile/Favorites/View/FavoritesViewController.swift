//
//  FavoritesViewController.swift
//  FakeNFT
//
//  Created by Andrei Kashin on 07.07.2023.
//

import UIKit

protocol FavoritesViewControllerProtocol {
    func updateUI()
    func showViewController(_ vc: UIViewController)
    func showEmptyCart()
    func showNoInternetView()
    func showProgressHUB()
    func dismissProgressHUB()
    
}

final class FavoritesViewController: UIViewController, FavoritesViewControllerProtocol {
    
    // MARK: - Constants
    
    private enum Constants {
        static let emptyFavoritesLabelText = Localization.profileEmptyFavoritesLabelText
        static let favoritesTitleText = Localization.profileFavoritesTitleText
    }
    
    // MARK: - Properties
    
    private var presenter: FavoritesPresenterProtocol
    
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
        emptyLabel.text = Constants.emptyFavoritesLabelText
        emptyLabel.font = .bold17
        emptyLabel.textColor = Image.appBlack.color
        return emptyLabel
    }()
    
    private lazy var favoriteNFTCollection: UICollectionView = {
        let favoriteNFTCollection = UICollectionView(
            frame: .zero,
            collectionViewLayout: UICollectionViewFlowLayout()
        )
        favoriteNFTCollection.translatesAutoresizingMaskIntoConstraints = false
        favoriteNFTCollection.register(FavoritesCell.self)
        favoriteNFTCollection.backgroundColor = Image.appWhite.color
        favoriteNFTCollection.dataSource = self
        favoriteNFTCollection.delegate = self
        return favoriteNFTCollection
    }()
    
    // MARK: - Init
    
    init(presenter: FavoritesPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        setupView()
        setConstraints()
        addCollection()
        presenter.viewIsReady()
    }
    
    // MARK: - Layout methods
    
    private func addCollection() {
        view.addSubview(favoriteNFTCollection)
        
        NSLayoutConstraint.activate([
            favoriteNFTCollection.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            favoriteNFTCollection.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            favoriteNFTCollection.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            favoriteNFTCollection.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    // MARK: - Actions
    
    @objc
    private func didTapBackButton() {
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Methods
    
    func updateUI() {
        favoriteNFTCollection.reloadSections(IndexSet(integer: 0))
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
        favoriteNFTCollection.isHidden = true
        emptyLabel.isHidden = false
        navigationItem.title = ""
    }
    
    func showNoInternetView() {
        navigationController?.pushViewController(NoInternetViewController(), animated: true)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    private func setupNavBar() {
        navigationItem.title = Constants.favoritesTitleText
        navigationController?.navigationBar.tintColor = Image.appBlack.color
        navigationItem.leftBarButtonItem = backButton
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

// MARK: - FavoritesCellDelegate

extension FavoritesViewController: FavoritesCellDelegate {
    func didTapDeleteItem(at indexPath: IndexPath) {
        presenter.didTapDeleteItem(at: indexPath)
    }
}

// MARK: - UICollectionViewDataSource

extension FavoritesViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        presenter.numberOfRowsInSection(section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell: FavoritesCell = collectionView.dequeueReusableCell(indexPath: indexPath)
        cell.configure(with: presenter.cellForItem(at: indexPath))
        cell.currentIndexPath = indexPath
        cell.delegate = self
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension FavoritesViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let availableWidth = collectionView.frame.width - 16 * 2 - 7
        return CGSize(width: availableWidth / 2, height: 80)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 7
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 12, left: 16, bottom: 16, right: 16)
    }
    
}
