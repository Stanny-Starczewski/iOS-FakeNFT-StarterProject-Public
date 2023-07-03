import UIKit

final class ProfileViewController: UIViewController {
    
    private let presenter: ProfilePresenterProtocol
    
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
        
        setupView()
        setConstraints()
    }
    
    // MARK: - Setup UI
    
    private func setupView() {
        view.backgroundColor = .appWhite
        title = "Профиль"
    }
}

// MARK: - ProfileViewProtocol

extension ProfileViewController: ProfileViewProtocol {
    
}

// MARK: - Setting Constraints

extension ProfileViewController {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            
        ])
    }
}
