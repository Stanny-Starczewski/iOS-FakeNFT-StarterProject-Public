import UIKit

final class CartViewController: UIViewController {
    
    // MARK: - UI
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.backgroundColor = .customBlue
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
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
        setupNavigationController()
    }
    
    // MARK: - Setup UI
    
    private func setupView() {
        view.backgroundColor = .appWhite
        view.addSubview(tableView)
    }
    
    private func setupNavigationController() {
        let sortButton = UIBarButtonItem(
            image: UIImage(named: "icon-sort"),
            style: .plain,
            target: self,
            action: #selector(sortButtonTapped)
        )
        navigationItem.rightBarButtonItem = sortButton
        navigationController?.navigationBar.tintColor = .appBlack
    }
    
    @objc
    private func sortButtonTapped() {
        presenter.didSortButtonTapped()
    }
}

// MARK: - CartViewProtocol

extension CartViewController: CartViewProtocol {
    func showViewController(_ vc: UIViewController) {
        present(vc, animated: true)
    }
}

// MARK: - Setting Constraints

extension CartViewController {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
