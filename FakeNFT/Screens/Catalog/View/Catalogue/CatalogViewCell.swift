import UIKit
import Kingfisher

final class CollectionListCell: UITableViewCell, ReuseIdentifying {
    
    // MARK: - UI Lazy properties
    
    private lazy var imageCategoryView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 12
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var collectionName: UILabel = {
        let label = UILabel()
        label.textColor = .appBlack
        label.textAlignment = .left
        label.font = UIFont.bold17
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Life Cycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageCategoryView.kf.cancelDownloadTask()
        imageCategoryView.image = nil
    }
}
// MARK: - EXTENSIONS

// MARK: - Setup UI

extension CollectionListCell {
    private func setupView() {
        addSubview(imageCategoryView)
        addSubview(collectionName)
        selectionStyle = .none
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            imageCategoryView.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            imageCategoryView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageCategoryView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageCategoryView.heightAnchor.constraint(equalToConstant: 140),
            imageCategoryView.bottomAnchor.constraint(equalTo: collectionName.topAnchor, constant: -4),
            collectionName.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionName.heightAnchor.constraint(equalToConstant: 22),
            collectionName.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -1)
        ])
    }
}

// MARK: - Configuring from DATA

extension CollectionListCell {
    func config(collectionItem: NFTCollection) {
        let imageURL = URL(string: collectionItem.cover.encodeUrl)
        imageCategoryView.kf.indicatorType = .activity
        imageCategoryView.kf.setImage(with: imageURL)
        
        collectionName.text = "\(collectionItem.name) (\(collectionItem.nfts.count))"
    }
}
