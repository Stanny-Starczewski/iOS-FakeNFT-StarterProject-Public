import UIKit

final class CartViewController: UIViewController {
    
    private let presenter: CartPresenterProtocol
    
    // MARK: - Life Cycle
    
    init(presenter: CartPresenterProtocol) {
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
        view.backgroundColor = .systemGray
    }
}

// MARK: - CartViewProtocol

extension CartViewController: CartViewProtocol {
    
}

// MARK: - Setting Constraints

extension CartViewController {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            
        ])
    }
}
