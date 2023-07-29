import UIKit

final class RatingStackView: UIStackView {
    private let fillStarImage: UIImage? = Image.iconStarFilled.image
    private let emptyStarImage: UIImage? = Image.iconStar.image
    
    init(countOfStars: Int) {
        super.init(frame: .zero)
        axis = .horizontal
        spacing = 2
        
        for starTag in 1...countOfStars {
            let imageView = UIImageView()
            imageView.image = emptyStarImage
            imageView.tag = starTag
            addArrangedSubview(imageView)
        }
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupRating(rating: Int) {
        for subview in subviews {
            if let imageView = subview as? UIImageView {
                imageView.image = imageView.tag > rating ? emptyStarImage : fillStarImage
            }
        }
    }
}
