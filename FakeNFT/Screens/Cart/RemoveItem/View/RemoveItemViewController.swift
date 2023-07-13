import UIKit

protocol RemoveItemViewProtocol: AnyObject {
    
}

final class RemoveItemViewController: UIViewController {
    
    // MARK: - Constants
    
    private struct Constants {
        static let confirmationText = "Вы уверены, что хотите удалить объект из корзины?"
        static let deleteButtonText = "Удалить"
        static let backButtonText = "Вернуться"
    }
    
    // MARK: - UI
    
    private lazy var itemImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Pumpkin")
        imageView.layer.cornerRadius = 12
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var confirmationLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.confirmationText
        label.font = .regular13
        label.textAlignment = .center
        label.numberOfLines = 2
        label.textColor = .appBlack
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var deleteButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(Constants.deleteButtonText, for: .normal)
        button.backgroundColor = .appBlack
        button.tintColor = .customRed
        button.layer.cornerRadius = 12
        button.titleLabel?.font = .regular17
        button.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var backButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(Constants.backButtonText, for: .normal)
        button.backgroundColor = .appBlack
        button.tintColor = .appWhite
        button.layer.cornerRadius = 12
        button.titleLabel?.font = .regular17
        button.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var buttonsStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [deleteButton, backButton])
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    // MARK: - Properties
    
    private let presenter: RemoveItemPresenterProtocol
    
    // MARK: - Life Cycle
    
    init(presenter: RemoveItemPresenterProtocol) {
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
        applyBlur()
        view.addSubview(itemImageView)
        view.addSubview(confirmationLabel)
        view.addSubview(buttonsStackView)
    }
    
    private func applyBlur() {
        view.backgroundColor = .clear
        let blurEffect = UIBlurEffect(style: .extraLight)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        view.addSubview(blurEffectView)
    }
    
    // MARK: - Actions
    
    @objc
    private func deleteButtonTapped() {
        print("delete")
    }
    
    @objc
    private func backButtonTapped() {
        dismiss(animated: true)
    }
}

// MARK: - RemoveItemViewProtocol

extension RemoveItemViewController: RemoveItemViewProtocol {
    
}

// MARK: - Setting Constraints

extension RemoveItemViewController {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            itemImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 244),
            itemImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            itemImageView.widthAnchor.constraint(equalToConstant: 108),
            itemImageView.heightAnchor.constraint(equalToConstant: 108),
            
            confirmationLabel.topAnchor.constraint(equalTo: itemImageView.bottomAnchor, constant: 12),
            confirmationLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 98),
            confirmationLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -98),
            
            buttonsStackView.topAnchor.constraint(equalTo: confirmationLabel.bottomAnchor, constant: 20),
            buttonsStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 56),
            buttonsStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -56),
            buttonsStackView.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
}
