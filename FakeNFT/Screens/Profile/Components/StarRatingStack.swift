//
//  StarRatingStack.swift
//  FakeNFT
//
//  Created by Andrei Kashin on 07.07.2023.
//

import UIKit

class StarRatingController: UIStackView {
    
    // MARK: - Properties
    
    var starsRating = 0
    
    // MARK: - Init
    
    init(starsRating: Int = 0) {
        super.init(frame: .zero)
        
        self.starsRating = starsRating
        
        var starTag = 1
        for _ in 0..<starsRating {
            let image = UIImageView()
            image.image = UIImage(named: "Star Empty")
            image.tag = starTag
            self.addArrangedSubview(image)
            starTag += 1
        }
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    func setStarsRating(rating: Int) {
        self.starsRating = rating
        let stackSubViews = self.subviews
        for subView in stackSubViews {
            if let image = subView as? UIImageView {
                if image.tag > starsRating {
                    image.image = UIImage(named: "Star Empty")
                } else {
                    image.image = UIImage(named: "Star Filled")
                }
            }
        }
    }
}
