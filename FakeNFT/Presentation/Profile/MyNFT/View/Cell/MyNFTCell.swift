//
//  MyNFTCell.swift
//  FakeNFT
//
//  Created by Andrei Kashin on 07.07.2023.
//

import UIKit

final class MyNFTCell: UITableViewCell, ReuseIdentifying {
    
    // MARK: - Constants
    
    private enum Constants {
        static let priceLabelText = Localization.profilePriceLabelText
        static let authorLabelText = Localization.profileAuthorLabelText
    }
    
    // MARK: - Properties

    var currentIndexPath: IndexPath?
    
    // MARK: - UI
    
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
    
    private lazy var authorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .regular13
        label.textColor = Image.appBlack.color
        return label
    }()
    
    private lazy var priceStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.alignment = .leading
        stackView.spacing = 2
        return stackView
    }()
    
    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .regular13
        label.text = Constants.priceLabelText
        label.textColor = Image.appBlack.color
        return label
    }()
    
    private lazy var priceValueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .bold17
        label.textColor = Image.appBlack.color
        return label
    }()
    
    // MARK: - Life Cycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup UI
    
    private func setupView() {
        backgroundColor = Image.appWhite.color
        selectionStyle = .none
        
        contentView.addSubview(nftImageView)
        contentView.addSubview(contentStackView)
        contentView.addSubview(priceStackView)
        contentStackView.addArrangedSubview(nameLabel)
        contentStackView.addArrangedSubview(ratingStackView)
        contentStackView.addArrangedSubview(authorLabel)
        priceStackView.addArrangedSubview(priceLabel)
        priceStackView.addArrangedSubview(priceValueLabel)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            nftImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            nftImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            nftImageView.heightAnchor.constraint(equalToConstant: 108),
            nftImageView.widthAnchor.constraint(equalToConstant: 108),
            
            contentStackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            contentStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 144),
            contentStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -88),
            ratingStackView.heightAnchor.constraint(equalToConstant: 12),
            
            priceStackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            priceStackView.leadingAnchor.constraint(equalTo: contentStackView.trailingAnchor, constant: -39)
        ])
    }
    
    // MARK: - Methods
    
    func configure(with item: Item) {
        nameLabel.text = item.name
        priceValueLabel.text = String(format: "%.2f ETH", item.price)
        authorLabel.text = "\(Constants.authorLabelText) \(item.author)"
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
