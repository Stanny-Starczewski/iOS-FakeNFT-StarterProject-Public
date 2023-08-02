import UIKit
import Kingfisher 

protocol CollectionNFTCellDelegate: AnyObject {
    func nftCellDidTapLike(_ cell: CollectionNFTCell)
    func nftCellAddToCart(_ cell: CollectionNFTCell)
}

final class CollectionNFTCell: UICollectionViewCell, ReuseIdentifying {
    weak var delegate: CollectionNFTCellDelegate?
    
    // MARK: - UI Lazy properties

    private lazy var nftImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 12
        return imageView
    }()
    
    private lazy var heartButton: UIButton = {
        let heartButton = UIButton(type: .custom)
        heartButton.setImage(Image.iconHeart.image, for: .normal)
        heartButton.addTarget(self, action: #selector(didTapHeartButton), for: .touchUpInside)
        return heartButton
    }()
    
    private lazy var ratingStackView = RatingStackView()
    
    private lazy var nftLabel: UILabel = {
        let label = UILabel()
        label.font = .bold17
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var priceValue: UILabel = {
        let label = UILabel()
        label.font = .medium10
        return label
    }()
    
    private lazy var nameAndPriceVerticalStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [nftLabel, priceValue])
        stackView.axis = .vertical
        stackView.spacing = 4
        stackView.alignment = .leading
        return stackView
    }()
    
    private lazy var cartButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(Image.iconCartDelete.image, for: .normal)
        button.addTarget(self, action: #selector(didTapCartButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var priceAndCartButtonHorizontalStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [nameAndPriceVerticalStackView, cartButton])
        stackView.axis = .horizontal
        stackView.distribution = .fill
        return stackView
    }()
    
    private lazy var numberFormatter: NumberFormatter = {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.locale = Locale.current
        return numberFormatter
    }()
    
    // MARK: - Initialization

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Functions

    func configure(with model: ItemViewModel, delegate: CollectionNFTCellDelegate) {
        self.delegate = delegate
        
        nftImageView.kf.setImage(with: model.imageURL)
        nftLabel.text = model.name
        var formatPrice = "\(model.price) ETH"
        if let price = numberFormatter.string(from: NSNumber(value: model.price)) {
            formatPrice = price
        }
        priceValue.text = "\(String(describing: formatPrice)) ETH"
        
        ratingStackView.setupRating(rating: model.rating)
        
        let orderIcon = model.isOrdered ? Image.iconCartDelete.image : Image.iconCartAdd.image
        cartButton.setImage(orderIcon, for: .normal)
        
        let heathIcon = model.isLiked ? Image.iconHeartFilled.image : Image.iconHeart.image
        heartButton.setImage(heathIcon, for: .normal)
    }
    
    @objc
    private func didTapCartButton() {
        delegate?.nftCellAddToCart(self)
    }
    
    @objc
    private func didTapHeartButton() {
        delegate?.nftCellDidTapLike(self)
    }
}

// MARK: - EXTENSIONS

// MARK: - Setup UI

private extension CollectionNFTCell {
    func setupView() {
        contentView.backgroundColor = Image.appWhite.color
        
        [nftImageView, heartButton, ratingStackView, priceAndCartButtonHorizontalStackView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview($0)
        }
        setupConstraints()
    }
    
    // MARK: - Setting Constraints

    func setupConstraints() {
        NSLayoutConstraint.activate([
            nftImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            nftImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            nftImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            nftImageView.widthAnchor.constraint(equalTo: nftImageView.heightAnchor, multiplier: 1.0 / 1.0),
            
            heartButton.topAnchor.constraint(equalTo: nftImageView.topAnchor),
            heartButton.trailingAnchor.constraint(equalTo: nftImageView.trailingAnchor),
            heartButton.heightAnchor.constraint(equalToConstant: 42),
            heartButton.widthAnchor.constraint(equalToConstant: 42),
            
            ratingStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            ratingStackView.topAnchor.constraint(equalTo: nftImageView.bottomAnchor, constant: 8),
            
            priceAndCartButtonHorizontalStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            priceAndCartButtonHorizontalStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            priceAndCartButtonHorizontalStackView.topAnchor.constraint(equalTo: ratingStackView.bottomAnchor, constant: 4)
        ])
    }
}
