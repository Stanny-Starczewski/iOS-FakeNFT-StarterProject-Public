//
//  FavoritesViewController.swift
//  FakeNFT
//
//  Created by Andrei Kashin on 07.07.2023.
//

import UIKit

final class FavoritesViewController: UIViewController {
    
    // MARK: - Layout elements
    
    private var nftImage: [String] = Array(0..<3).map { "\($0)" }
    private var nftName: [String] = [ "Lilo", "Spring", "April"]
    private var nftPrice: [String] = [ "1,78 ETH", "1,99 ETH", "2,99 ETH" ]
    private var nftRating: [Int] = [ 3, 4, 5 ]
    
    private lazy var backButton = UIBarButtonItem(
        image: UIImage(named: "Backward"),
        style: .plain,
        target: self,
        action: #selector(didTapBackButton)
    )
    
    private lazy var emptyLabel: UILabel = {
        let emptyLabel = UILabel()
        emptyLabel.translatesAutoresizingMaskIntoConstraints = false
        emptyLabel.text = "У Вас ещё нет избранных NFT"
        emptyLabel.font = UIFont.boldSystemFont(ofSize: 17)
        emptyLabel.textColor = .appBlack
        return emptyLabel
    }()
    
    private lazy var favoriteNFTCollection: UICollectionView = {
        let favoriteNFTCollection = UICollectionView(
            frame: .zero,
            collectionViewLayout: UICollectionViewFlowLayout()
        )
        favoriteNFTCollection.translatesAutoresizingMaskIntoConstraints = false
        favoriteNFTCollection.register(FavoritesCell.self)
        favoriteNFTCollection.dataSource = self
        favoriteNFTCollection.delegate = self
        return favoriteNFTCollection
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavBar()
        setupView()
        setConstraints()
        addCollection()
    }
    
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
    
    // MARK: - Layout methods
    
    private func setupNavBar() {
        navigationController?.navigationBar.tintColor = .appBlack
        navigationItem.leftBarButtonItem = backButton
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

extension FavoritesViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
   //     guard let likedNFTs = likedNFTs else { return 0 }
   //     return likedNFTs.count
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      //  let cell: FavoritesCell = collectionView.dequeueReusableCell(indexPath: indexPath)
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FavoritesCell.reuseIdentifier, for: indexPath) as? FavoritesCell
       // cell.backgroundColor = .white
        
        let image = UIImage(named: nftImage[indexPath.row])
        cell?.nftImage.image = image
        cell?.nftRating.setStarsRating(rating: nftRating[indexPath.row])
        cell?.nftName.text = nftName[indexPath.row]
        cell?.nftPriceValue.text = nftPrice[indexPath.row]
//        guard let likedNFTs = likedNFTs,
//              !likedNFTs.isEmpty else { return FavoritesCell() }
//        let likedNFT = likedNFTs[indexPath.row]
//
//        let model = FavoritesCell.Model(
//            image: likedNFT.images.first ?? "",
//            name: likedNFT.name,
//            rating: likedNFT.rating,
//            price: likedNFT.price,
//            isFavorite: true,
//            id: likedNFT.id
//        )
//        cell.tapAction = { [unowned viewModel] in
//            viewModel.favoriteUnliked(id: likedNFT.id)
//        }
//        cell.configureCell(with: model)
        
        return cell ?? UICollectionViewCell()
    }
}

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
