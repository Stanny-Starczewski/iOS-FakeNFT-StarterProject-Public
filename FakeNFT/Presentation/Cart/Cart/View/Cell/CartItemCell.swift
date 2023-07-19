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
        label.textColor = .appBlack
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var ratingImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "icon-stars-0")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var priceDescriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Цена"
        label.font = .regular13
        label.textColor = .appBlack
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.text = "0 ETH"
        label.numberOfLines = 1
        label.font = .bold17
        label.textColor = .appBlack
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var deleteItemButton: UIButton = {
        let button = UIButton(type: .system)
        button.setBackgroundImage(UIImage(named: "icon-cart-delete")?.withTintColor(.appBlack), for: .normal)
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
        backgroundColor = .appWhite
        contentView.addSubview(wrapperView)
        wrapperView.addSubview(itemImageView)
        wrapperView.addSubview(itemNameLabel)
        wrapperView.addSubview(ratingImageView)
        wrapperView.addSubview(priceDescriptionLabel)
        wrapperView.addSubview(priceLabel)
        wrapperView.addSubview(deleteItemButton)
    }
    
    // MARK: - Configure
    
    func configure(with item: NftItem) {
        itemNameLabel.text = item.name
        priceLabel.text = String(format: "%.2f ETH", item.price)
        ratingImageView.image = UIImage(named: "icon-stars-\(Int(item.rating))")
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
            wrapperView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            wrapperView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
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
            
            ratingImageView.topAnchor.constraint(equalTo: itemNameLabel.bottomAnchor, constant: 4),
            ratingImageView.leadingAnchor.constraint(equalTo: itemImageView.trailingAnchor, constant: 20),
            ratingImageView.widthAnchor.constraint(equalToConstant: 68),
            ratingImageView.heightAnchor.constraint(equalToConstant: 12),
            
            priceDescriptionLabel.topAnchor.constraint(equalTo: ratingImageView.bottomAnchor, constant: 12),
            priceDescriptionLabel.leadingAnchor.constraint(equalTo: itemImageView.trailingAnchor, constant: 20),
            
            priceLabel.topAnchor.constraint(equalTo: priceDescriptionLabel.bottomAnchor, constant: 2),
            priceLabel.leadingAnchor.constraint(equalTo: itemImageView.trailingAnchor, constant: 20),
            priceLabel.trailingAnchor.constraint(equalTo: deleteItemButton.leadingAnchor, constant: -20)
        ])
    }
}
