import UIKit
import WebKit

final class AuthorViewController: UIViewController, UIGestureRecognizerDelegate {
    private var viewModel: AuthorViewModel
    
    // MARK: - UI Lazy properties
    
    private lazy var webView: WKWebView = {
        let webView = WKWebView()
        webView.navigationDelegate = self
        return webView
    }()
    
    private lazy var backButton: UIBarButtonItem = {
        let backButton = UIBarButtonItem(
            image: UIImage.Icons.backward,
            style: .plain,
            target: self,
            action: #selector(didTapBackButton)
        )
        return backButton
    }()
  
    // MARK: - Initialization

    init(viewModel: AuthorViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        bindViewModel()
        loadPage()
    }
    
    // MARK: - Functions

    @objc
    private func didTapBackButton() {
        navigationController?.popViewController(animated: true)
    }
    
    private func loadPage() {
        guard let url = URL(string: viewModel.authorPageURL) else {
            return
        }
        
        let request = URLRequest(url: url)
        viewModel.changeLoadingStatus(loadingInProgress: true)
        webView.load(request)
    }
    
    private func bindViewModel() {
        viewModel.$loadingInProgress.observe { [weak self] _ in
            guard let self = self else { return }
            if self.viewModel.loadingInProgress {
                UIBlockingProgressHUD.show()
            } else {
                UIBlockingProgressHUD.dismiss()
            }
        }
    }
}

// MARK: - EXTENSIONS

// MARK: - Setup UI

private extension AuthorViewController {
    func setupView() {
        view.backgroundColor = .appWhite
        tabBarController?.tabBar.isHidden = true
        
        webView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(webView)
        
        setupNavBar()
        setupConstraints()
    }
    
    func setupNavBar() {
        navigationController?.navigationBar.barTintColor = .white
        navigationItem.leftBarButtonItem = backButton
        navigationController?.interactivePopGestureRecognizer?.delegate = self
    }
    
    // MARK: - Setting Constraints

    func setupConstraints() {
        NSLayoutConstraint.activate([
            webView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            webView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            webView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            webView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension AuthorViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        viewModel.changeLoadingStatus(loadingInProgress: false)
    }
}
