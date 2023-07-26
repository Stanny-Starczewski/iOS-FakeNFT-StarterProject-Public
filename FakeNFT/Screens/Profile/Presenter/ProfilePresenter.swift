import Foundation

protocol ProfilePresenterProtocol: AnyObject {
    func viewDidLoad()
    func didTapEditButton()
    func didTapMyNFTScreen()
    func didTapFavoritesScreen()
}

final class ProfilePresenter {
    
    // MARK: - Properties
    
    weak var view: ProfileViewControllerProtocol?
    private var profile: Profile?
    private let screenAssembly: ScreenAssembly
    
    // MARK: - Init
    
    init(view: ProfileViewControllerProtocol? = nil, profile: Profile? = nil, screenAssembly: ScreenAssembly) {
        self.view = view
        self.profile = profile
        self.screenAssembly = screenAssembly
    }
    
    // MARK: - Methods
    
    func getProfileData() {
        
        UIBlockingProgressHUD.show()
        
        let networkClient = DefaultNetworkClient()
        
        networkClient.send(request: GetProfileRequest(), type: Profile.self) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let profile):
                    self?.profile = profile
                    self?.view?.updateProfileScreen(profile: profile)
                case .failure(let error):
                    print(error)
                    self?.view?.showNoInternetView()
                }
                UIBlockingProgressHUD.dismiss()
            }
        }
    }
    
    func didTapEditButton() {
        guard let profile else { return }
        let editProfileViewController = screenAssembly.makeEditProfileScreen(profile: profile)
        view?.showModalTypeViewController(editProfileViewController)
    }
    
    func didTapMyNFTScreen() {
        let myNFTViewController = screenAssembly.makeMyNFTScreen()
        view?.showNavigationTypeViewController(myNFTViewController)
    }
    
    func didTapFavoritesScreen() {
        let favoritesViewController = screenAssembly.makeFavoritesScreen()
        view?.showNavigationTypeViewController(favoritesViewController)
    }
}

// MARK: - ProfilePresenterProtocol

extension ProfilePresenter: ProfilePresenterProtocol {
    
    func viewDidLoad() {
        getProfileData()
    }
    
}
