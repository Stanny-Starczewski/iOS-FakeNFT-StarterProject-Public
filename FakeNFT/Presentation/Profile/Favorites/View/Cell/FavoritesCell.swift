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
    
    weak var delegate: FavoritesCellDelegate?
    var currentIndexPath: IndexPath?
    
    // MARK: - Layout elements
    
    private lazy var nftImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 12
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    private lazy var contentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.alignment = .leading
        stackView.spacing = 4
        return stackView
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .bold17
        label.textColor = Image.appBlack.color
        return label
    }()
    
    private lazy var ratingStackView = RatingStackView()
    
    private lazy var priceValueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .regular15
        return label
    }()
    
    private lazy var favoriteButton: UIButton = {
        let button = UIButton()
        button.setImage(Image.iconHeartFilled.image, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(didTapFavoriteButton), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupView()
        setConstraints()
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
    
    private func setupView() {
        contentView.addSubview(nftImageView)
        contentView.addSubview(favoriteButton)
        contentView.addSubview(contentStackView)
        contentStackView.addArrangedSubview(nameLabel)
        contentStackView.addArrangedSubview(ratingStackView)
        contentStackView.addArrangedSubview(priceValueLabel)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            nftImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            nftImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            nftImageView.heightAnchor.constraint(equalToConstant: 80),
            nftImageView.widthAnchor.constraint(equalToConstant: 80),
            
            favoriteButton.topAnchor.constraint(equalTo: nftImageView.topAnchor, constant: -6),
            favoriteButton.trailingAnchor.constraint(equalTo: nftImageView.trailingAnchor, constant: 6),
            favoriteButton.heightAnchor.constraint(equalToConstant: 42),
            favoriteButton.widthAnchor.constraint(equalToConstant: 42),
            
            contentStackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            contentStackView.leadingAnchor.constraint(equalTo: nftImageView.trailingAnchor, constant: 12),
            ratingStackView.heightAnchor.constraint(equalToConstant: 12)
        ])
    }
    
    // MARK: - Methods
    
    func configure(with item: Item) {
        nameLabel.text = item.name
        priceValueLabel.text = String(format: "%.2f ETH", item.price)
        ratingStackView.setupRating(rating: item.rating)
        guard
            let imageUrlString = item.images.first,
            let imageUrl = URL(string: imageUrlString)
        else { return }
        nftImageView.kf.indicatorType = .activity
        nftImageView.kf.setImage(with: imageUrl) { [weak self] _ in
            self?.nftImageView.kf.indicatorType = .none
        }
    }
}
