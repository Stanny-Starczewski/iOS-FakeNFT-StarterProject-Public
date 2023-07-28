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
            let imageName = self.isFavorite ? "Heart Filled" : "Heart Empty"
            self.setImage(UIImage(named: imageName), for: .normal)
        }
    }
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
