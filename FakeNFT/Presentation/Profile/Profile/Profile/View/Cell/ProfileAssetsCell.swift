//
//  ProfileAssetsCell.swift
//  FakeNFT
//
//  Created by Andrei Kashin on 07.07.2023.
//

import UIKit

final class ProfileAssetsCell: UITableViewCell {
    
    // MARK: - Properties
    
    static let reuseIdentifier = "ProfileAssetsCell"
    
    // MARK: - Layout elements
    
    var assetLabel: UILabel = {
        var assetLabel = UILabel()
        assetLabel.translatesAutoresizingMaskIntoConstraints = false
        assetLabel.font = .bold17
        assetLabel.textColor = Image.appBlack.color
        return assetLabel
    }()
    
    var assetValueLabel: UILabel = {
        var assetValue = UILabel()
        assetValue.translatesAutoresizingMaskIntoConstraints = false
        assetValue.font = .bold17
        assetValue.textColor = Image.appBlack.color
        return assetValue
    }()
    
    var forwardButton: UIImageView = {
        var forwardButton = UIImageView()
        forwardButton.translatesAutoresizingMaskIntoConstraints = false
        forwardButton.image = Image.iconForward.image
        forwardButton.tintColor = Image.appBlack.color
        return forwardButton
    }()
    
    // MARK: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupView()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Layout methods
    
    private func setupView() {
        backgroundColor = Image.appWhite.color
        
        addSubview(assetLabel)
        addSubview(assetValueLabel)
        addSubview(forwardButton)
        
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            
            assetLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            assetLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            
            assetValueLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            assetValueLabel.leadingAnchor.constraint(equalTo: assetLabel.trailingAnchor, constant: 8),
            
            forwardButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            forwardButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
            
        ])
    }
}
