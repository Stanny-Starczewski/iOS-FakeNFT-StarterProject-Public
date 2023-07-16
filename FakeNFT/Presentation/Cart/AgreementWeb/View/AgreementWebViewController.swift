import UIKit
import WebKit

protocol AgreementWebViewProtocol: AnyObject {
    func load(on request: URLRequest)
    func setProgressValue(_ newValue: Float)
    func setProgressHidden(_ isHidden: Bool)
}

final class AgreementWebViewController: UIViewController {
    
    // MARK: - Constants
    
    private struct Constants {
        static let backButtonImage = UIImage(named: "icon-back")
    }
    
    // MARK: - UI
    
    private lazy var webView: WKWebView = {
        let webView = WKWebView()
        webView.translatesAutoresizingMaskIntoConstraints = false
        return webView
    }()
    
    private lazy var progressView: UIProgressView = {
        let progressView = UIProgressView(progressViewStyle: .default)
        progressView.progressTintColor = .customBlue
        progressView.translatesAutoresizingMaskIntoConstraints = false
        return progressView
    }()
    
    private lazy var backButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(Constants.backButtonImage, for: .normal)
        button.tintColor = .appBlack
        button.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: - Properties
    
    private let presenter: AgreementWebPresenterProtocol
    
    private var estimatedProgressObservation: NSKeyValueObservation?
    
    // MARK: - Life Cycle
    
    init(presenter: AgreementWebPresenterProtocol) {
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
        presenter.viewIsReady()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addObserverProgress()
    }
    
    // MARK: - Setup UI
    
    private func setupView() {
        view.backgroundColor = .appWhite
        view.addSubview(backButton)
        view.addSubview(webView)
        view.addSubview(progressView)
    }
    
    private func addObserverProgress() {
        estimatedProgressObservation = webView.observe(
            \.estimatedProgress,
             options: [],
             changeHandler: { [weak self] _, _ in
                 guard let self else { return }
                 self.presenter.didUpdateProgressValue(self.webView.estimatedProgress)
             }
        )
    }
    
    // MARK: - Actions
    
    @objc
    private func backButtonTapped() {
        dismiss(animated: true)
    }
}

// MARK: - AgreementWebViewProtocol

extension AgreementWebViewController: AgreementWebViewProtocol {
    func load(on request: URLRequest) {
        webView.load(request)
    }
    
    func setProgressValue(_ newValue: Float) {
        progressView.progress = newValue
    }

    func setProgressHidden(_ isHidden: Bool) {
        progressView.isHidden = isHidden
    }
}

// MARK: - Setting Constraints

extension AgreementWebViewController {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 9),
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 9),
            backButton.widthAnchor.constraint(equalToConstant: 24),
            backButton.heightAnchor.constraint(equalToConstant: 24),
            
            progressView.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: 9),
            progressView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            progressView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            progressView.heightAnchor.constraint(equalToConstant: 3),
            
            webView.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: 9),
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            webView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
