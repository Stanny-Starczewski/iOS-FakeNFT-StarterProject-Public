//
//  MyNFTCell.swift
//  FakeNFT
//
//  Created by Andrei Kashin on 07.07.2023.
//

import UIKit

final class MyNFTCell: UITableViewCell {
    
    // MARK: - Properties
    
    static let reuseIdentifier = "MyNFTCell"
    
    //MARK: - Layout elements
    
    var myNFTImage: UIImageView = {
        let image = UIImage(named: "0")
        let myNFTImage = UIImageView(image: image)
        myNFTImage.translatesAutoresizingMaskIntoConstraints = false
        myNFTImage.layer.cornerRadius = 12
        myNFTImage.layer.masksToBounds = true
        return myNFTImage
    }()
    
    var myNFTStack: UIStackView = {
        let myNFTStack = UIStackView()
        myNFTStack.translatesAutoresizingMaskIntoConstraints = false
        myNFTStack.axis = .vertical
        myNFTStack.distribution = .equalSpacing
        myNFTStack.alignment = .leading
        myNFTStack.spacing = 4
        return myNFTStack
    }()
    
    var myNFTNameLabel: UILabel = {
        let myNFTNameLabel = UILabel()
        myNFTNameLabel.translatesAutoresizingMaskIntoConstraints = false
        myNFTNameLabel.font = .boldSystemFont(ofSize: 17)
        myNFTNameLabel.textColor = .appBlack
        myNFTNameLabel.text = "Lilo"
        return myNFTNameLabel
    }()
    
    var myNFTRating: StarRatingController = {
        let myNFTRating = StarRatingController(starsRating: 5)
        myNFTRating.translatesAutoresizingMaskIntoConstraints = false
        return myNFTRating
    }()
    
    var myNFTAuthorLabel: UILabel = {
        let myNFTAuthorLabel = UILabel()
        myNFTAuthorLabel.translatesAutoresizingMaskIntoConstraints = false
        myNFTAuthorLabel.font = .systemFont(ofSize: 13)
        myNFTAuthorLabel.textColor = .appBlack
        myNFTAuthorLabel.text = "от John Doe"
        return myNFTAuthorLabel
    }()
    
    var myNFTPriceStack: UIStackView = {
        let myNFTPriceStack = UIStackView()
        myNFTPriceStack.translatesAutoresizingMaskIntoConstraints = false
        myNFTPriceStack.axis = .vertical
        myNFTPriceStack.distribution = .equalSpacing
        myNFTPriceStack.alignment = .leading
        myNFTPriceStack.spacing = 2
        return myNFTPriceStack
    }()
    
    var myNFTPriceLabel: UILabel = {
        let myNFTPriceLabel = UILabel()
        myNFTPriceLabel.translatesAutoresizingMaskIntoConstraints = false
        myNFTPriceLabel.font = .systemFont(ofSize: 13)
        myNFTPriceLabel.text = "Цена"
        myNFTPriceLabel.textColor = .appBlack
        return myNFTPriceLabel
    }()
    
    var myNFTPriceValueLabel: UILabel = {
        let myNFTPriceValueLabel = UILabel()
        myNFTPriceValueLabel.translatesAutoresizingMaskIntoConstraints = false
        myNFTPriceValueLabel.font = .boldSystemFont(ofSize: 17)
        myNFTPriceValueLabel.text = "1,78 ETH"
        myNFTPriceValueLabel.textColor = .appBlack
        return myNFTPriceValueLabel
    }()
    
    var myNFTFavoriteButton: FavoriteButton = {
        let myNFTFavoriteButton = FavoriteButton()
        myNFTFavoriteButton.translatesAutoresizingMaskIntoConstraints = false
        return myNFTFavoriteButton
    }()
    
    // MARK: - Init
    
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
        backgroundColor = .appWhite
        
        contentView.addSubview(myNFTImage)
        myNFTImage.addSubview(myNFTFavoriteButton)
        
        contentView.addSubview(myNFTStack)
        myNFTStack.addArrangedSubview(myNFTNameLabel)
        myNFTStack.addArrangedSubview(myNFTRating)
        myNFTStack.addArrangedSubview(myNFTAuthorLabel)
        
        contentView.addSubview(myNFTPriceStack)
        
        myNFTPriceStack.addArrangedSubview(myNFTPriceLabel)
        myNFTPriceStack.addArrangedSubview(myNFTPriceValueLabel)
        
        
    }
    
    // MARK: - Setting Constraints
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            
            myNFTImage.centerYAnchor.constraint(equalTo: centerYAnchor),
            myNFTImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            myNFTImage.heightAnchor.constraint(equalToConstant: 108),
            myNFTImage.widthAnchor.constraint(equalToConstant: 108),
            
            myNFTFavoriteButton.topAnchor.constraint(equalTo: myNFTImage.topAnchor),
            myNFTFavoriteButton.trailingAnchor.constraint(equalTo: myNFTImage.trailingAnchor),
            myNFTFavoriteButton.heightAnchor.constraint(equalToConstant: 42),
            myNFTFavoriteButton.widthAnchor.constraint(equalToConstant: 42),
            
            myNFTStack.centerYAnchor.constraint(equalTo: centerYAnchor),
            myNFTStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 144),
            myNFTStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -88),
            myNFTRating.heightAnchor.constraint(equalToConstant: 12),
            
            myNFTPriceStack.centerYAnchor.constraint(equalTo: centerYAnchor),
            myNFTPriceStack.leadingAnchor.constraint(equalTo: myNFTStack.trailingAnchor)
            
        ])
    }
}
