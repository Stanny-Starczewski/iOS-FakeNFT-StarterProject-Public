import UIKit
import Kingfisher

protocol ProfileViewProtocol: AnyObject {
    func updateProfileScreen(profile: Profile)
    func showNoInternetView()
    func showModalTypeViewController(_ vc: UIViewController)
    func showNavigationTypeViewController(_ vc: UIViewController)
    func showProgressHUB()
    func dismissProgressHUB()
}

final class ProfileViewController: UIViewController {
    
    // MARK: - Constants
    
    private enum Constants {
        static let myNftLabelText = Localization.myNftLabelText
        static let favoritesNftLabelText = Localization.favoritesNftLabelText
        static let developerLabelText = Localization.developerLabelText
    }
    
    // MARK: - Properties
    
    private var presenter: ProfilePresenterProtocol?
    
    // MARK: - UI
    
    private lazy var editButton = UIBarButtonItem(
        image: Image.iconEdit.image,
        style: .plain,
        target: self,
        action: #selector(didTapEditButton)
    )
    
    private lazy var avatarImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 35
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .bold22
        label.textColor = Image.appBlack.color
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = .regular13
        label.textColor = Image.appBlack.color
        label.textAlignment = .left
        return label
    }()
    
    private lazy var websiteLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.accessibilityIdentifier = "websiteLabel"
        label.font = .regular15
        label.textColor = Image.customBlue.color
        let tap = UITapGestureRecognizer(target: self, action: #selector(websiteDidTap))
        label.isUserInteractionEnabled = true
        label.addGestureRecognizer(tap)
        return label
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
    
    private lazy var assetLabel = [
        Constants.myNftLabelText,
        Constants.favoritesNftLabelText,
        Constants.developerLabelText
    ]
    
    // MARK: - Life Cycle
    
    init(presenter: ProfilePresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        setupView()
        setConstraints()
        presenter?.viewDidLoad()
    }
    
    // MARK: - Actions
    
    @objc
    private func didTapEditButton() {
        presenter?.didTapEditButton()
    }
    
    @objc
    private func websiteDidTap() {
        self.present(
            WebsiteViewController(webView: nil, websiteURL: websiteLabel.text),
            animated: true
        )
    }
    
    // MARK: - Layout methods
    
    private func setupNavBar() {
        navigationController?.navigationBar.tintColor = Image.appBlack.color
        navigationItem.rightBarButtonItem = editButton
    }
    
    private func setupView() {
        view.backgroundColor = Image.appWhite.color
        
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

// MARK: - ProfileViewProtocol

extension ProfileViewController: ProfileViewProtocol {
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
    
    func showModalTypeViewController(_ vc: UIViewController) {
        present(vc, animated: true)
    }
    
    func showNavigationTypeViewController(_ vc: UIViewController) {
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func showNoInternetView() {
        navigationController?.pushViewController(NoInternetViewController(), animated: true)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    func showProgressHUB() {
        UIBlockingProgressHUD.show()
    }
    
    func dismissProgressHUB() {
        UIBlockingProgressHUD.dismiss()
    }
}

// MARK: - UITableViewDataSource

extension ProfileViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ProfileAssetsCell.reuseIdentifier)  as? ProfileAssetsCell
        cell?.backgroundColor = Image.appWhite.color
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
