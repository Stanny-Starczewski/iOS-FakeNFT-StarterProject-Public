import UIKit

final class CatalogViewController: UIViewController, CatalogueViewModelDelegate {
    
    // MARK: - Properties
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = Image.appWhite.color
        tableView.register(CollectionListCell.self)
        tableView.rowHeight = 187
        tableView.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()
    
    private lazy var sortButton = UIBarButtonItem(
        image: Image.iconSort.image,
        style: .plain,
        target: catalogueViewModel,
        action: #selector(CatalogueViewModel.sortCollections)
    )
    
    private var catalogueViewModel: CatalogueViewModel
    private var setupManager = SetupManager.shared
    private var alertBuilder: AlertBuilderProtocol?
    
    // MARK: - Initialization

    init(viewModel: CatalogueViewModel) {
        self.catalogueViewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        catalogueViewModel.delegate = self

        observeViewModel()

        setupView()
        setupNavBar()
        
        UIBlockingProgressHUD.show()
        catalogueViewModel.getCollections()
        
        alertBuilder = AlertBuilder()
    }
    
    private func observeViewModel() {
        catalogueViewModel.$collections.observe { [weak self] _ in
            guard let self = self else { return }
            self.tableView.reloadData()
            UIBlockingProgressHUD.dismiss()
        }
        catalogueViewModel.$errorDescription.observe { [weak self] _ in
            UIBlockingProgressHUD.dismiss()
            guard let self, let alertBuilder else { return }
            let alert = alertBuilder.makeErrorAlertWithRepeatAction(with: self.catalogueViewModel.errorDescription, {
                self.catalogueViewModel.getCollections()
            })
            self.present(alert, animated: true)
        }
    }
    
    // MARK: - Functions

    func presentSortActionSheet(_ actionSheet: UIAlertController) {
        present(actionSheet, animated: true)
    }
    
    func didSelectSortType(_ sortType: SortType) {
        catalogueViewModel.setSortType(sortType: sortType)
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
}

// MARK: - EXTENSIONS

// MARK: - Setup UI

extension CatalogViewController {
    private func setupView() {
        view.backgroundColor = Image.appWhite.color
        view.addSubview(tableView)
        tabBarController?.tabBar.barTintColor = Image.appWhite.color
        setupConstraints()
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
        navigationController?.navigationBar.tintColor = Image.appBlack.color
    }
}
extension CatalogViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        catalogueViewModel.collections.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: CollectionListCell = tableView.dequeueReusableCell()
        
        let collectionItem = catalogueViewModel.collections[indexPath.row]
        cell.config(collectionItem: collectionItem)
        
        return cell
    }
}

extension CatalogViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let collection = catalogueViewModel.collections[indexPath.row]
        
        let collectionVM = CollectionViewModel(collectionModel: collection, networkService: NetworkService())
        let collectionVC = CollectionViewController(viewModel: collectionVM)
        
        collectionVC.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(collectionVC, animated: true)
    }
}
