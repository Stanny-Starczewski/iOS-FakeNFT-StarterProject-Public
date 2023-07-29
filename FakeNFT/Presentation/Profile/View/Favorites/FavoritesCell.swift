//
//  FavoritesCell.swift
//  FakeNFT
//
//  Created by Andrei Kashin on 24.07.2023.
//

import UIKit

protocol FavoritesCellDelegate: AnyObject {
    func didTapDeleteItem(at indexPath: IndexPath)
}

final class FavoritesCell: UICollectionViewCell, ReuseIdentifying {
    
    // MARK: - Properties
    
    static let reuseIdentifier = "FavoritesCell"
    
    weak var delegate: FavoritesCellDelegate?
    
    var currentIndexPath: IndexPath?
    
    // MARK: - Layout elements
    
    var nftImage: UIImageView = {
        let nftImage = UIImageView()
        nftImage.translatesAutoresizingMaskIntoConstraints = false
        nftImage.layer.cornerRadius = 12
        nftImage.layer.masksToBounds = true
        return nftImage
    }()
    
    var nftStack: UIStackView = {
        let nftStack = UIStackView()
        nftStack.translatesAutoresizingMaskIntoConstraints = false
        nftStack.axis = .vertical
        nftStack.distribution = .equalSpacing
        nftStack.alignment = .leading
        nftStack.spacing = 4
        return nftStack
    }()
    
    var nftName: UILabel = {
        let nftName = UILabel()
        nftName.translatesAutoresizingMaskIntoConstraints = false
        nftName.font = .boldSystemFont(ofSize: 17)
        nftName.textColor = .black
        return nftName
    }()
    
    var nftRating: StarRatingController = {
        let nftRating = StarRatingController(starsRating: 5)
        nftRating.translatesAutoresizingMaskIntoConstraints = false
        nftRating.spacing = 2
        return nftRating
    }()
    
    var nftPriceValue: UILabel = {
        let nftPriceValue = UILabel()
        nftPriceValue.translatesAutoresizingMaskIntoConstraints = false
        nftPriceValue.font = .systemFont(ofSize: 15)
        nftPriceValue.text = "0 ETH"
        return nftPriceValue
    }()
    
    lazy var nftFavorite: UIButton = {
        let nftFavorite = UIButton()
        nftFavorite.setImage(UIImage(named: "Heart Filled"), for: .normal)
        nftFavorite.translatesAutoresizingMaskIntoConstraints = false
        nftFavorite.addTarget(self, action: #selector(didTapFavoriteButton), for: .touchUpInside)
        return nftFavorite
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        addImage()
        addFavoriteButton()
        addNFTStack()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Actions
    
    @objc
    private func didTapFavoriteButton() {
        guard let currentIndexPath else { return }
        delegate?.didTapDeleteItem(at: currentIndexPath)
    }
    
    // MARK: - Layout methods
    
    private func addImage() {
        contentView.addSubview(nftImage)
        nftImage.image = UIImage(named: "UserImagePlaceholder")
        NSLayoutConstraint.activate([
            nftImage.centerYAnchor.constraint(equalTo: centerYAnchor),
            nftImage.leadingAnchor.constraint(equalTo: leadingAnchor),
            nftImage.heightAnchor.constraint(equalToConstant: 80),
            nftImage.widthAnchor.constraint(equalToConstant: 80)
        ])
    }
    
    private func addFavoriteButton() {
        contentView.addSubview(nftFavorite)
        NSLayoutConstraint.activate([
            nftFavorite.topAnchor.constraint(equalTo: nftImage.topAnchor, constant: -6),
            nftFavorite.trailingAnchor.constraint(equalTo: nftImage.trailingAnchor, constant: 6),
            nftFavorite.heightAnchor.constraint(equalToConstant: 42),
            nftFavorite.widthAnchor.constraint(equalToConstant: 42)
        ])
    }
    
    private func addNFTStack() {
        contentView.addSubview(nftStack)
        nftStack.addArrangedSubview(nftName)
        nftStack.addArrangedSubview(nftRating)
        nftStack.addArrangedSubview(nftPriceValue)
        NSLayoutConstraint.activate([
            nftStack.centerYAnchor.constraint(equalTo: centerYAnchor),
            nftStack.leadingAnchor.constraint(equalTo: nftImage.trailingAnchor, constant: 12),
            nftRating.heightAnchor.constraint(equalToConstant: 12)
        ])
    }
    
    // MARK: - Methods
    
    func configure(with item: NFTNetworkModel) {
        nftName.text = item.name
        nftPriceValue.text = String(format: "%.2f ETH", item.price)
        nftRating.setStarsRating(rating: item.rating)
        guard
            let imageUrlString = item.images.first,
            let imageUrl = URL(string: imageUrlString)
        else { return }
        nftImage.kf.indicatorType = .activity
        nftImage.kf.setImage(with: imageUrl) { [weak self] _ in
            self?.nftImage.kf.indicatorType = .none
        }
    }
}
