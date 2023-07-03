import UIKit

final class CatalogViewController: UIViewController {
    
    private let presenter: CatalogPresenterProtocol
    
    // MARK: - Life Cycle
    
    init(presenter: CatalogPresenterProtocol) {
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
        view.backgroundColor = .systemBlue
    }
}

// MARK: - CatalogViewProtocol

extension CatalogViewController: CatalogViewProtocol {
    
}

// MARK: - Setting Constraints

extension CatalogViewController {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            
        ])
    }
}
