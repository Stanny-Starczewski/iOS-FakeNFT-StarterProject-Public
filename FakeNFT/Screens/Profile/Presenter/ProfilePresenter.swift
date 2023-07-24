import Foundation

protocol ProfilePresenterProtocol {
   // var view: ProfileViewControllerProtocol? { get set }
    func viewDidLoad()
    func didTapEditButton()
}

final class ProfilePresenter {
    
    weak var view: ProfileViewControllerProtocol?
    private var profile: Profile?
    
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
                    print(profile)
                case .failure(let error):
                    print(error)
                    self?.view?.showNoInternetView()
                }
                UIBlockingProgressHUD.dismiss()
            }
        }
    }
    
    func didTapEditButton() {
        let editProfileViewController = EditProfileViewController()
//        self.navigationController?.pushViewController(editProfileViewController, animated: true)
        view?.showViewController(editProfileViewController)
    }
}

// MARK: - ProfilePresenterProtocol

extension ProfilePresenter: ProfilePresenterProtocol {
    
    func viewDidLoad() {
        getProfileData()
    }
    
}
