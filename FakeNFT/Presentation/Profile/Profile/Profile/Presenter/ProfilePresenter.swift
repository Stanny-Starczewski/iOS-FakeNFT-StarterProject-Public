import Foundation

protocol ProfilePresenterProtocol: AnyObject {
    func viewIsReady()
    func didTapEditButton()
    func didTapMyNFTScreen()
    func didTapFavoritesScreen()
}

final class ProfilePresenter {
    
    // MARK: - Properties
    
    weak var view: ProfileViewProtocol?
    private var profile: Profile?
    private let screenAssembly: ScreenAssemblyProtocol
    private let networkService: NetworkServiceProtocol
    private let alertBuilder: AlertBuilderProtocol
    
    // MARK: - Life Cycle
    
    init(
        view: ProfileViewProtocol? = nil,
        profile: Profile? = nil,
        screenAssembly: ScreenAssemblyProtocol,
        networkService: NetworkServiceProtocol,
        alertBuilder: AlertBuilderProtocol
    ) {
        self.view = view
        self.profile = profile
        self.screenAssembly = screenAssembly
        self.networkService = networkService
        self.alertBuilder = alertBuilder
    }
}

// MARK: - ProfilePresenterProtocol

extension ProfilePresenter: ProfilePresenterProtocol {
    func viewIsReady() {
        view?.showProgressHUB()
        networkService.getProfile { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let profile):
                view?.dismissProgressHUB()
                self.profile = profile
                self.view?.updateProfileScreen(profile: profile)
            case .failure(let error):
                view?.dismissProgressHUB()
                let alert = self.alertBuilder.makeErrorAlert(with: error.localizedDescription)
                self.view?.showModalTypeViewController(alert)
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
        
        view?.showProgressHUB()
        networkService.updateProfile(profile: newProfile) { [weak self] error in
            guard let self else { return }
            if let error {
                view?.dismissProgressHUB()
                let alert = self.alertBuilder.makeErrorAlert(with: error.localizedDescription)
                self.view?.showModalTypeViewController(alert)
            }
        }
    }
}
