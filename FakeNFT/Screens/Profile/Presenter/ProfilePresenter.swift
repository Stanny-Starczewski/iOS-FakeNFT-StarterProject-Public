import Foundation

protocol ProfilePresenterProtocol {
    var view: ProfileViewControllerProtocol? { get set }
    func viewDidLoad()
}

struct ProfileResult {
    let name: String
    let avatarURL: URL
    let description: String
    let website: String
    let nfts: String
    let likes: String
    let id: String
}

final class ProfilePresenter {
    
    weak var view: ProfileViewControllerProtocol?
    private(set) var profile: ProfileResult?
    
    // MARK: - Methods
    
    func getProfileData() {
        
        UIBlockingProgressHUD.show()
        
        let networkClient = DefaultNetworkClient()
        
        networkClient.send(request: GetProfileRequest(), type: Profile.self) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let profile):
                    let profileResult = ProfileResult(
                        name: profile.name,
                        avatarURL: URL(string: profile.avatar)!,
                        description: profile.description,
                        website: profile.website,
                        nfts: "(\(String(profile.nfts.count)))",
                        likes: "(\(String(profile.likes.count)))",
                        id: profile.id
                    )
                    self?.view?.updateProfileScreen(profile: profileResult)
                    print(profile)
                    
                case .failure(let error):
                    print(error)
                    self?.view?.showNoInternetView()
                }
                UIBlockingProgressHUD.dismiss()
            }
        }
    }
}

// MARK: - ProfilePresenterProtocol

extension ProfilePresenter: ProfilePresenterProtocol {
    
    func viewDidLoad() {
        getProfileData()
    }
    
}
