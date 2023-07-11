import UIKit

protocol CartViewProtocol: AnyObject {
    func showViewController(_ vc: UIViewController)
}

final class CartViewController: UIViewController {
    
    // MARK: - Constants
    
    private struct Constants {
        static let bottomViewCornerRadius: CGFloat = 12
        static let iconSort = UIImage(named: "icon-sort")
        static let paymentButtonText = "К оплате"
    }
    
    // MARK: - UI
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.backgroundColor = .appWhite
        tableView.separatorStyle = .none
        tableView.contentInset = UIEdgeInsets(
            top: 20,
            left: 0,
            bottom: 20,
            right: 0
        )
        tableView.register(
            CartItemCell.self,
            forCellReuseIdentifier: CartItemCell.reuseIdentifier
        )
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private lazy var bottomView: UIView = {
        let view = UIView()
        view.backgroundColor = .appLightGrey
        view.layer.cornerRadius = Constants.bottomViewCornerRadius
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var quantityLabel: UILabel = {
        let label = UILabel()
        label.text = "3 NFT"
        label.font = .regular15
        label.textColor = .appBlack
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var amountLabel: UILabel = {
        let label = UILabel()
        label.text = "5,34 ETH"
        label.font = .bold17
        label.textColor = .customGreen
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var totalStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [quantityLabel, amountLabel])
        stackView.axis = .vertical
        stackView.spacing = 2
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var paymentButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .appBlack
        button.tintColor = .customWhite
        button.layer.cornerRadius = 16
        button.setTitle(Constants.paymentButtonText, for: .normal)
        button.titleLabel?.font = .bold17
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var bottomStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [totalStackView, paymentButton])
        stackView.axis = .horizontal
        stackView.spacing = 24
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
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
        setDelegates()
    }
    
    // MARK: - Setup UI
    
    private func setupView() {
        view.backgroundColor = .appWhite
        view.addSubview(tableView)
        view.addSubview(bottomView)
        bottomView.addSubview(bottomStackView)
    }
    
    private func setupNavigationController() {
        let sortButton = UIBarButtonItem(
            image: Constants.iconSort,
            style: .plain,
            target: self,
            action: #selector(sortButtonTapped)
        )
        navigationItem.rightBarButtonItem = sortButton
        navigationController?.navigationBar.tintColor = .appBlack
    }
    
    private func setDelegates() {
        tableView.dataSource = self
        tableView.delegate = self
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

// MARK: - UITableViewDataSource

extension CartViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(
                withIdentifier: CartItemCell.reuseIdentifier,
                for: indexPath
            ) as? CartItemCell
        else { return UITableViewCell() }
        return cell
    }
}

// MARK: - UITableViewDelegate

extension CartViewController: UITableViewDelegate {
    
}

// MARK: - Setting Constraints

extension CartViewController {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            bottomView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bottomView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bottomView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0),
//            bottomView.heightAnchor.constraint(equalToConstant: 76),
            
            bottomStackView.topAnchor.constraint(equalTo: bottomView.topAnchor, constant: 16),
            bottomStackView.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor, constant: 16),
            bottomStackView.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor, constant: -16),
            bottomStackView.bottomAnchor.constraint(equalTo: bottomView.bottomAnchor, constant: -16)
        ])
    }
}
