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
        
        view?.showProgressHUB()
        
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
                self?.view?.dismissProgressHUB()
            }
        }
    }
    
    func didTapEditButton() {
        guard let profile else { return }
        let editProfileViewController = screenAssembly.makeEditProfileScreen(profile: profile, delegate: self)
        view?.showModalTypeViewController(editProfileViewController)
    }
    
    func didTapMyNFTScreen() {
        let myNFTViewController = screenAssembly.makeMyNFTScreen()
        view?.showNavigationTypeViewController(myNFTViewController)
    }
    
    func didTapFavoritesScreen() {
        let favoritesViewController = screenAssembly.makeFavoritesScreen(delegate: self)
        view?.showNavigationTypeViewController(favoritesViewController)
    }
}

// MARK: - ProfilePresenterProtocol

extension ProfilePresenter: ProfilePresenterProtocol {
    
    func viewDidLoad() {
        getProfileData()
    }
}

// MARK: - EditProfileDelegate

extension ProfilePresenter: EditProfileDelegate {
    func updateProfile(_ profile: Profile) {
        self.profile = profile
        view?.updateProfileScreen(profile: profile)
    }
}

// MARK: - FavoritesDelegate

extension ProfilePresenter: FavoritesDelegate {
    func didDeleteItem(at id: String) {
        guard
            let profile,
            let deletedIndex = profile.likes.firstIndex(of: id)
        else { return }
        
        var likes = profile.likes
        likes.remove(at: deletedIndex)
        
        let newProfile = Profile(
            name: profile.name,
            avatar: profile.avatar,
            description: profile.description,
            website: profile.website,
            nfts: profile.nfts,
            likes: likes,
            id: profile.id
        )
        view?.updateProfileScreen(profile: newProfile)
        let networkClient = DefaultNetworkClient()
        let request = PutProfileRequest(dto: newProfile)
        view?.showProgressHUB()
        networkClient.send(request: request, type: Profile.self) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let profile):
                    print(profile)
                    self?.getProfileData()
                    self?.view?.dismissProgressHUB()
                case .failure(let error):
                    print(error)
                    self?.view?.dismissProgressHUB()
                }
            }
        }
    }
}
