//
//  CartItemCell.swift
//  FakeNFT
//
//  Created by Anton Vikhlyaev on 14.07.2023.
//

import UIKit
import Kingfisher

protocol CartItemCellDelegate: AnyObject {
    func didDeleteItemButtonTapped(at indexPath: IndexPath)
}

final class CartItemCell: UITableViewCell, ReuseIdentifying {
    
    // MARK: - Constants
    
    private enum Constants {
        static let priceLabelText = Localization.cartPriceLabelText
    }
    
    // MARK: - Properties
    
    var currentIndexPath: IndexPath?
    
    weak var delegate: CartItemCellDelegate?
    
    // MARK: - UI
    
    private lazy var wrapperView: UIView = {
        let wrapperView = UIView()
        wrapperView.translatesAutoresizingMaskIntoConstraints = false
        return wrapperView
    }()
    
    private lazy var itemImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 12
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var itemNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = .bold17
        label.textColor = Image.appBlack.color
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var ratingStackView = RatingStackView()
    
    private lazy var priceDescriptionLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.priceLabelText
        label.font = .regular13
        label.textColor = Image.appBlack.color
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = .bold17
        label.textColor = Image.appBlack.color
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var deleteItemButton: UIButton = {
        let button = UIButton(type: .system)
        button.setBackgroundImage(
            Image.iconCartDelete.image.withTintColor(Image.appBlack.color),
            for: .normal
        )
        button.addTarget(self, action: #selector(deleteItemButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: - Life Cycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup UI
    
    private func setupCell() {
        selectionStyle = .none
        backgroundColor = Image.appWhite.color
        contentView.addSubview(wrapperView)
        wrapperView.addSubview(itemImageView)
        wrapperView.addSubview(itemNameLabel)
        wrapperView.addSubview(ratingStackView)
        wrapperView.addSubview(priceDescriptionLabel)
        wrapperView.addSubview(priceLabel)
        wrapperView.addSubview(deleteItemButton)
    }
    
    // MARK: - Configure
    
    func configure(with item: NftItem) {
        itemNameLabel.text = item.name
        priceLabel.text = String(format: "%.2f ETH", item.price)
        ratingStackView.setupRating(rating: item.rating)
        guard
            let imageUrlString = item.images.first,
            let imageUrl = URL(string: imageUrlString)
        else { return }
        itemImageView.kf.indicatorType = .activity
        itemImageView.kf.setImage(with: imageUrl) { [weak self] _ in
            self?.itemImageView.kf.indicatorType = .none
        }
    }
    
    // MARK: - Actions
    
    @objc
    private func deleteItemButtonTapped() {
        guard let currentIndexPath else { return }
        delegate?.didDeleteItemButtonTapped(at: currentIndexPath)
    }
}

// MARK: - Setting Constraints

extension CartItemCell {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            wrapperView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            wrapperView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            wrapperView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            wrapperView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            
            itemImageView.topAnchor.constraint(equalTo: wrapperView.topAnchor),
            itemImageView.leadingAnchor.constraint(equalTo: wrapperView.leadingAnchor),
            itemImageView.bottomAnchor.constraint(equalTo: wrapperView.bottomAnchor),
            itemImageView.widthAnchor.constraint(equalToConstant: 108),
            itemImageView.heightAnchor.constraint(equalToConstant: 108),
            
            deleteItemButton.trailingAnchor.constraint(equalTo: wrapperView.trailingAnchor),
            deleteItemButton.centerYAnchor.constraint(equalTo: wrapperView.centerYAnchor),
            deleteItemButton.widthAnchor.constraint(equalToConstant: 40),
            deleteItemButton.heightAnchor.constraint(equalToConstant: 40),
            
            itemNameLabel.topAnchor.constraint(equalTo: wrapperView.topAnchor, constant: 8),
            itemNameLabel.leadingAnchor.constraint(equalTo: itemImageView.trailingAnchor, constant: 20),
            itemNameLabel.trailingAnchor.constraint(equalTo: deleteItemButton.leadingAnchor, constant: -20),
            
            ratingStackView.topAnchor.constraint(equalTo: itemNameLabel.bottomAnchor, constant: 4),
            ratingStackView.leadingAnchor.constraint(equalTo: itemImageView.trailingAnchor, constant: 20),

            priceDescriptionLabel.topAnchor.constraint(equalTo: ratingStackView.bottomAnchor, constant: 12),
            priceDescriptionLabel.leadingAnchor.constraint(equalTo: itemImageView.trailingAnchor, constant: 20),
            
            priceLabel.topAnchor.constraint(equalTo: priceDescriptionLabel.bottomAnchor, constant: 2),
            priceLabel.leadingAnchor.constraint(equalTo: itemImageView.trailingAnchor, constant: 20),
            priceLabel.trailingAnchor.constraint(equalTo: deleteItemButton.leadingAnchor, constant: -20)
        ])
    }
}
