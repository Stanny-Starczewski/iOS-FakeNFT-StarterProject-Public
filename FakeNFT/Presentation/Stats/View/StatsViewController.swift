import UIKit

final class StatsViewController: UIViewController {
    
    private let presenter: StatsPresenterProtocol
    
    // MARK: - Life Cycle
    
    init(presenter: StatsPresenterProtocol) {
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
        title = "Статистика"
    }
}

// MARK: - StatsViewProtocol

extension StatsViewController: StatsViewProtocol {
    
}

// MARK: - Setting Constraints

extension StatsViewController {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            
        ])
    }
}
