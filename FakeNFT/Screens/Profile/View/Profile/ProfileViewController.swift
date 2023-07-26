import UIKit
import Kingfisher

protocol ProfileViewControllerProtocol: AnyObject {
    func updateProfileScreen(profile: Profile)
    func showNoInternetView()
    func showModalTypeViewController(_ vc: UIViewController)
    func showNavigationTypeViewController(_ vc: UIViewController)
}

final class ProfileViewController: UIViewController, ProfileViewControllerProtocol {
    
    // MARK: - Properties
    
    private var presenter: ProfilePresenterProtocol?
    
    private lazy var assetLabel: [String] = [
        "Мои NFT",
        "Избранные NFT",
        "О разработчике"
    ]
    
    // MARK: - Layout elements
    
    private lazy var editButton = UIBarButtonItem(
        image: UIImage(named: "Edit"),
        style: .plain,
        target: self,
        action: #selector(didTapEditButton)
    )
    
    private lazy var avatarImage: UIImageView = {
        let profilePhoto = UIImage(named: "ProfilePhoto")
        let avatarImage = UIImageView(image: profilePhoto)
        avatarImage.translatesAutoresizingMaskIntoConstraints = false
        avatarImage.layer.cornerRadius = 35
        avatarImage.layer.masksToBounds = true
        return avatarImage
    }()
    
    private lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.text = "" // "Joaquin Phoenix"
        nameLabel.font = UIFont.boldSystemFont(ofSize: 22)
        nameLabel.textColor = .appBlack
        return nameLabel
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let descriptionLabel = UILabel()
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.minimumLineHeight = 18
        descriptionLabel.attributedText = NSAttributedString(string: "",
                                                             attributes: [.kern: 0.08, NSAttributedString.Key.paragraphStyle: paragraphStyle])
        descriptionLabel.numberOfLines = 0
        descriptionLabel.font = UIFont.systemFont(ofSize: 13)
        descriptionLabel.textColor = .appBlack
        descriptionLabel.textAlignment = .left
        return descriptionLabel
    }()
    
    private lazy var websiteLabel: UILabel = {
        let websiteLabel = UILabel()
        websiteLabel.translatesAutoresizingMaskIntoConstraints = false
        websiteLabel.accessibilityIdentifier = "websiteLabel"
        let tapAction = UITapGestureRecognizer(target: self, action: #selector(websiteDidTap(_:)))
        websiteLabel.isUserInteractionEnabled = true
        websiteLabel.addGestureRecognizer(tapAction)
        websiteLabel.attributedText = NSAttributedString(string: "", attributes: [.kern: 0.24])
        websiteLabel.font = UIFont.systemFont(ofSize: 15)
        websiteLabel.textColor = .blue
        return websiteLabel
    }()
    
    private lazy var profileAssetsTable: UITableView = {
        let profileAssetsTable = UITableView()
        profileAssetsTable.translatesAutoresizingMaskIntoConstraints = false
        profileAssetsTable.register(ProfileAssetsCell.self, forCellReuseIdentifier: ProfileAssetsCell.reuseIdentifier)
        profileAssetsTable.dataSource = self
        profileAssetsTable.delegate = self
        profileAssetsTable.separatorStyle = .none
        profileAssetsTable.allowsMultipleSelection = false
        return profileAssetsTable
    }()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavBar()
        setupView()
        setConstraints()
        presenter?.viewDidLoad()
        
    }
    
    // MARK: - Init
    
    init(presenter: ProfilePresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Actions
    
    @objc
    private func didTapEditButton() {
        presenter?.didTapEditButton()
    }
    
    @objc
    private func websiteDidTap(_ sender: UITapGestureRecognizer) {
        self.present(WebsiteViewController(webView: nil, websiteURL: websiteLabel.text), animated: true)
    }
    
    // MARK: - Methods
    
    func showModalTypeViewController(_ vc: UIViewController) {
        present(vc, animated: true)
    }
    
    func showNavigationTypeViewController(_ vc: UIViewController) {
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func updateProfileScreen(profile: Profile) {
        let imageUrlString = profile.avatar
        let imageUrl = URL(string: imageUrlString)
        avatarImage.kf.setImage(
            with: imageUrl,
            placeholder: UIImage(named: "ProfilePhoto"),
            options: [.processor(RoundCornerImageProcessor(cornerRadius: 35))])
        
        nameLabel.text = profile.name
        descriptionLabel.text = profile.description
        websiteLabel.text = profile.website
        let nftsCountLabel = profileAssetsTable.cellForRow(at: [0, 0]) as? ProfileAssetsCell
        nftsCountLabel?.assetValueLabel.text = "(\(String(profile.nfts.count)))"
        let likesCountLabel = profileAssetsTable.cellForRow(at: [0, 1]) as? ProfileAssetsCell
        likesCountLabel?.assetValueLabel.text = "(\(String(profile.likes.count)))"
    }
    
    func showNoInternetView() {
        navigationController?.pushViewController(NoInternetViewController(), animated: true)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    // MARK: - Layout methods
    
    private func setupNavBar() {
        navigationController?.navigationBar.tintColor = .appBlack
        navigationItem.rightBarButtonItem = editButton
    }
    
    private func setupView() {
        view.backgroundColor = .appWhite
        
        view.addSubview(avatarImage)
        view.addSubview(nameLabel)
        view.addSubview(descriptionLabel)
        view.addSubview(websiteLabel)
        view.addSubview(profileAssetsTable)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            
            avatarImage.heightAnchor.constraint(equalToConstant: 70),
            avatarImage.widthAnchor.constraint(equalToConstant: 70),
            avatarImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            avatarImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            nameLabel.topAnchor.constraint(equalTo: avatarImage.topAnchor, constant: 21),
            nameLabel.leadingAnchor.constraint(equalTo: avatarImage.trailingAnchor, constant: 16),
            
            descriptionLabel.topAnchor.constraint(equalTo: avatarImage.bottomAnchor, constant: 20),
            descriptionLabel.heightAnchor.constraint(equalToConstant: 72),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
            websiteLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 8),
            websiteLabel.leadingAnchor.constraint(equalTo: descriptionLabel.leadingAnchor),
            
            profileAssetsTable.topAnchor.constraint(equalTo: websiteLabel.bottomAnchor, constant: 40),
            profileAssetsTable.heightAnchor.constraint(equalToConstant: 54 * 3),
            profileAssetsTable.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            profileAssetsTable.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            
        ])
    }
}

// MARK: - UITableViewDataSource

extension ProfileViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: ProfileAssetsCell.reuseIdentifier)  as? ProfileAssetsCell
        
        cell?.backgroundColor = .appWhite
        cell?.assetLabel.text = assetLabel[indexPath.row]
        cell?.assetValueLabel.text = ""
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 54
    }
}

// MARK: - UITableViewDelegate

extension ProfileViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        //        navigationController?.pushViewController(assetViewController[indexPath.row], animated: true)
        switch indexPath.row {
        case 0: presenter?.didTapMyNFTScreen()
        case 1: presenter?.didTapFavoritesScreen()
        case 2: let viewController = AboutViewController()
            navigationController?.pushViewController(viewController, animated: true)
        default:
            return
        }
    }
}
