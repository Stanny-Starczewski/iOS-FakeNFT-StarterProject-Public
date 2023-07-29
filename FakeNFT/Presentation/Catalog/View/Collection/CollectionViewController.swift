import UIKit 
import Kingfisher

final class CollectionViewController: UIViewController, UIGestureRecognizerDelegate {
    
    // MARK: - UI properties

    private lazy var backButton = UIBarButtonItem(
        image: Image.iconBack.image,
        style: .plain,
        target: self,
        action: #selector(didTapBackButton)
    )
    
    private lazy var coverImage: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 16
        imageView.clipsToBounds = true
        imageView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        return imageView
    }()
    
    private lazy var collectionNameLabel: UILabel = {
        let label = UILabel()
        label.font = .bold22
        return label
    }()
    
    private lazy var authorLink: UILabel = {
        let label = UILabel()
        label.font = .regular15
        label.textColor = .blue
        label.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapAuthorLink))
        label.addGestureRecognizer(tapGesture)
        return label
    }()
    
    private lazy var authorTitle: UILabel = {
        let label = UILabel()
        label.font = .regular13
        label.text = Names.nftCollectionAuthor
        return label
    }()
    
    private let authorHorizontalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .firstBaseline
        stackView.spacing = 4
        return stackView
    }()
    
    private lazy var nftDescriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .regular13
        label.numberOfLines = 0
        return label
    }()
    
    private let fullDescriptionVerticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.spacing = 5
        return stackView
    }()
    
    private lazy var nftCollectionView: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collection.backgroundColor = .clear
        collection.dataSource = self
        collection.delegate = self
        collection.allowsMultipleSelection = false
        collection.register(CollectionNFTCell.self)
        return collection
    }()
    
    private lazy var contentView: UIView = {
        let contentView = UIView()
        return contentView
    }()
    
    private var viewModel: CollectionViewModel
    private var alertBuilder: AlertBuilderProtocol
    
    private let collectionConfig = UICollectionView.Config(
        cellCount: 3,
        leftInset: 16,
        rightInset: 16,
        topInset: 0,
        bottomInset: 0,
        height: 192,
        cellSpacing: 8
    )
        
    // MARK: - Initialization

    init(viewModel: CollectionViewModel, alertBuilder: AlertBuilderProtocol = AlertBuilder()) {
        self.viewModel = viewModel
        self.alertBuilder = alertBuilder
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        bindViewModel()
        setupValuesForUIElements()
        viewModel.loadNFTForCollection()
        viewModel.getAuthorURL()
    }
    
    // MARK: - Functions

    @objc
    private func didTapBackButton() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc
    private func didTapAuthorLink() {
        let aboutAuthorViewModel = AuthorViewModel(authorPageURL: viewModel.authorModel.website)
        let aboutAuthorScreen = AuthorViewController(viewModel: aboutAuthorViewModel)
        aboutAuthorScreen.modalPresentationStyle = .fullScreen
        
        navigationController?.pushViewController(aboutAuthorScreen, animated: true)
    }
    
    private func bindViewModel() {
        viewModel.$nftItems.observe { [weak self] _ in
            guard let self = self else { return }
            self.nftCollectionView.reloadData()
        }
        
        viewModel.$loadingState.observe { [weak self] loadingState in
            guard let self = self else { return }
            
            switch loadingState {
            case .loading:
                UIBlockingProgressHUD.show()
            case .loaded:
                UIBlockingProgressHUD.dismiss()
            case .failed:
                let alert = self.alertBuilder.makeErrorAlertWithRepeatAction(with: self.viewModel.mainLoadErrorDescription) {
                    self.viewModel.loadNFTForCollection()
                    self.viewModel.getAuthorURL()
                }
                self.present(alert, animated: true)
            default:
                break 
            }
        }
        
        viewModel.$loadingInProgress.observe { [weak self] _ in
            guard let self = self else { return }
            if self.viewModel.loadingInProgress {
                UIBlockingProgressHUD.show()
            } else {
                UIBlockingProgressHUD.dismiss()
            }
        }
        
        viewModel.$authorModel.observe { [weak self] _ in
            guard let self = self else { return }
            self.authorLink.text = self.viewModel.authorModel.name
        }
        viewModel.$mainLoadErrorDescription.observe { [weak self] _ in
            guard let self = self else { return }
            let alert = self.alertBuilder.makeErrorAlertWithRepeatAction(with: viewModel.mainLoadErrorDescription) {
                self.viewModel.loadNFTForCollection()
                self.viewModel.getAuthorURL()
            }
            self.present(alert, animated: true)
        }
        
        viewModel.$addToCartErrorDescription.observe { [weak self] _ in
            guard let self = self else { return }
            let alert = self.alertBuilder.makeErrorAlert(with: self.viewModel.addToCartErrorDescription)
            self.present(alert, animated: true)
        }
        
        viewModel.$addToFavoritesErrorDescription.observe { [weak self] _ in
            guard let self = self else { return }
            let alert = self.alertBuilder.makeErrorAlert(with: self.viewModel.addToFavoritesErrorDescription)
            self.present(alert, animated: true)
        }
    }
}

// MARK: - EXTENSIONS

// MARK: - Setup UI

private extension CollectionViewController {
    func setupView() {
        view.backgroundColor = Image.appWhite.color
        
        [coverImage, collectionNameLabel, fullDescriptionVerticalStackView, nftCollectionView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
        authorHorizontalStackView.addArrangedSubview(authorTitle)
        authorHorizontalStackView.addArrangedSubview(authorLink)
        
        fullDescriptionVerticalStackView.addArrangedSubview(authorHorizontalStackView)
        fullDescriptionVerticalStackView.addArrangedSubview(nftDescriptionLabel)
        
        setupNavBar()
        setupConstraints()
    }
    
    func setupValuesForUIElements() {
        let coverURL = URL(string: viewModel.collectionModel.cover.encodeUrl)
        coverImage.kf.setImage(with: coverURL)
        
        collectionNameLabel.text = viewModel.collectionModel.name
        authorLink.text = viewModel.authorModel.name
        nftDescriptionLabel.text = viewModel.collectionModel.description
    }
    
    // MARK: - Setting Navigation Bar
    
    func setupNavBar() {
        navigationItem.leftBarButtonItem = backButton
        navigationController?.navigationBar.tintColor = Image.appBlack.color
        navigationController?.interactivePopGestureRecognizer?.delegate = self
    }
    
    // MARK: - Setting Constraints

    func setupConstraints() {
        NSLayoutConstraint.activate([
            coverImage.topAnchor.constraint(equalTo: view.topAnchor),
            coverImage.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            coverImage.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            coverImage.heightAnchor.constraint(equalToConstant: 310),
            
            collectionNameLabel.topAnchor.constraint(equalTo: coverImage.bottomAnchor, constant: 16),
            collectionNameLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            
            fullDescriptionVerticalStackView.topAnchor.constraint(equalTo: collectionNameLabel.bottomAnchor, constant: 8),
            fullDescriptionVerticalStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            fullDescriptionVerticalStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
            nftCollectionView.topAnchor.constraint(equalTo: fullDescriptionVerticalStackView.bottomAnchor, constant: 24),
            nftCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            nftCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            nftCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension CollectionViewController: CollectionNFTCellDelegate {
    func nftCellDidTapLike(_ cell: CollectionNFTCell) {
        guard let indexPath = nftCollectionView.indexPath(for: cell) else { return }
        viewModel.onAddToFavorites(indexPath: indexPath)
    }
    
    func nftCellAddToCart(_ cell: CollectionNFTCell) {
        guard let indexPath = nftCollectionView.indexPath(for: cell) else { return }
        viewModel.onAddToCart(indexPath: indexPath)
    }
}

extension CollectionViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.numberOfItems
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: CollectionNFTCell = collectionView.dequeueReusableCell(indexPath: indexPath)
        let model = viewModel.nftItems[indexPath.row]
           
        cell.configure(with: model, delegate: self)
        return cell
    }
}

extension CollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let availableSpace = collectionView.frame.width - collectionConfig.paddingWidth
        let cellWidth = availableSpace / collectionConfig.cellCount
        return CGSize(width: cellWidth, height: collectionConfig.height)
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAt section: Int
    ) -> UIEdgeInsets {
        UIEdgeInsets(
            top: collectionConfig.topInset,
            left: collectionConfig.leftInset,
            bottom: collectionConfig.bottomInset,
            right: collectionConfig.rightInset
        )
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumInteritemSpacingForSectionAt section: Int
    ) -> CGFloat {
        collectionConfig.cellSpacing
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAt section: Int
    ) -> CGFloat {
        collectionConfig.cellSpacing
    }
}
