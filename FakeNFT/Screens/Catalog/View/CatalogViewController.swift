import UIKit

final class CatalogViewController: UIViewController {
    
    // MARK: - UI Lazy properties
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(CollectionListCell.self)
        tableView.rowHeight = 187
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()
    
    private lazy var sortButton = UIBarButtonItem(
        image: UIImage.Icons.filter,
        style: .plain,
        target: self,
        action: #selector(sortCollections)
    )
    
    private var catalogueViewModel: CatalogueViewModel?
    private var setupManager = SetupManager.shared
    private let presenter: CatalogPresenterProtocol
    
    // MARK: - Life Cycle
    
    init(presenter: CatalogPresenterProtocol, viewModel: CatalogueViewModel) {
        self.presenter = presenter
        self.catalogueViewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if catalogueViewModel == nil {
            catalogueViewModel = CatalogueViewModel(provider: CatalogueDataProvider()) // 1
        }
        
        bindViewModel()

        setupView()
        setupConstraints()
        setupNavBar()
        
        UIProgressHUD.show()
        catalogueViewModel?.getCollections()
    }
    
    func initialise(viewModel: CatalogueViewModel) {
        self.catalogueViewModel = viewModel
    }
    
    private func bindViewModel() {
        guard let viewModel = catalogueViewModel else { return }
        viewModel.$collections.bind { [weak self] _ in
            guard let self = self else { return }
            self.tableView.reloadData()
            UIProgressHUD.dismiss()
        }
    }
    
    // MARK: - Actions

    @objc
    private func sortCollections() {
        let actionSheet = UIAlertController(title: "Сортировка",
                                            message: nil,
                                            preferredStyle: .actionSheet)
        
        let sortByName = UIAlertAction(title: "По названию",
                                       style: .default) { [weak self] _ in
            guard let self = self else { return }
            
            UIView.animate(withDuration: 0.3) {
                self.catalogueViewModel?.setSortType(sortType: SortType.sortByName)
                self.view.layoutIfNeeded()
            }
        }
        
        let sortByCount = UIAlertAction(title: "По количеству NFT",
                                        style: .default) { [weak self] _ in
            guard let self = self else { return }
            
            UIView.animate(withDuration: 0.3) {
                self.catalogueViewModel?.setSortType(sortType: SortType.sortByCount)
                self.view.layoutIfNeeded()
            }
        }
        
        let cancel = UIAlertAction(title: "Отмена", style: .cancel)
        
        actionSheet.addAction(sortByName)
        actionSheet.addAction(sortByCount)
        actionSheet.addAction(cancel)
        
        present(actionSheet, animated: true)
    }
}

// MARK: - EXTENSIONS

// MARK: - CatalogViewProtocol

extension CatalogViewController: CatalogViewProtocol {
    
}

// MARK: - Setup UI

extension CatalogViewController {
    private func setupView() {
        view.backgroundColor = .appWhite
        title = "Каталог"
        view.addSubview(tableView)
        tabBarController?.tabBar.barTintColor = .appWhite // 1
    }
}
// MARK: - Setting Constraints

extension CatalogViewController {
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

// MARK: - Setting Navigation Bar

extension CatalogViewController {
    private func setupNavBar() {
        navigationItem.rightBarButtonItem = sortButton
        navigationController?.navigationBar.tintColor = .appBlack
    }
}
extension CatalogViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        catalogueViewModel?.collections.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: CollectionListCell = tableView.dequeueReusableCell()
        
        guard let collectionItem = catalogueViewModel?.collections[indexPath.row] else { return UITableViewCell() }
        cell.config(collectionItem: collectionItem)
        
        return cell
    }
}

extension CatalogViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let collection = catalogueViewModel?.collections[indexPath.row] else { return }
        
        let collectionVM = CollectionViewModel(collectionModel: collection)
        let collectionVC = CollectionViewController(viewModel: collectionVM)
        
        collectionVC.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(collectionVC, animated: true)
    }
}
