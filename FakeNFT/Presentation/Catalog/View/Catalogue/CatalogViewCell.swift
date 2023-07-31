import UIKit
import Kingfisher

final class CollectionListCell: UITableViewCell, ReuseIdentifying {
    
    // MARK: - UI properties

    private lazy var categoryImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 12
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var collectionNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = Image.appBlack.color
        label.textAlignment = .left
        label.font = UIFont.bold17
        return label
    }()
    
    private let cellInsets = UIEdgeInsets(top: 0, left: 0, bottom: 1, right: 0)
    
    // MARK: - Initialization

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle

    override func prepareForReuse() {
        super.prepareForReuse()
        categoryImageView.kf.cancelDownloadTask()
    }
    
    // MARK: - Setup UI
    
    private func setupView() {
        backgroundColor = Image.appWhite.color
        addSubview(categoryImageView)
        addSubview(collectionNameLabel)
        [categoryImageView, collectionNameLabel].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        setupConstraints()
    }
    
    // MARK: - Setting constraints

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            categoryImageView.topAnchor.constraint(equalTo: topAnchor, constant: cellInsets.top),
            categoryImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            categoryImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            categoryImageView.heightAnchor.constraint(equalToConstant: 140),
            collectionNameLabel.topAnchor.constraint(equalTo: categoryImageView.bottomAnchor, constant: -12),
            collectionNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionNameLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -cellInsets.bottom)
        ])
    }
    
    // MARK: - Configuring from DATA
    
    func config(collectionItem: Collection) {
        let imageURL = URL(string: collectionItem.cover.encodeUrl)
        categoryImageView.kf.indicatorType = .activity
        categoryImageView.kf.setImage(with: imageURL)
        
        collectionNameLabel.text = "\(collectionItem.name) (\(collectionItem.nfts.count))"
    }
}
