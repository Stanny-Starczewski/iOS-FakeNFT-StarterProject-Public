//
//  FavoriteButton.swift
//  FakeNFT
//
//  Created by Andrei Kashin on 07.07.2023.
//

import UIKit

final class FavoriteButton: UIButton {
    
    // MARK: - Properties
    
    var nftID: String?
    
    var isFavorite: Bool = true {
        didSet {
            if isFavorite {
                setImage(Image.iconHeartFilled.image, for: .normal)
            } else {
                setImage(Image.iconHeart.image, for: .normal)
            }
        }
    }
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup UI
    
    private func setupView() {
        translatesAutoresizingMaskIntoConstraints = false
    }
}
