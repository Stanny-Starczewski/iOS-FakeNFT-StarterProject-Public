//
//  EditProfileViewController.swift
//  FakeNFT
//
//  Created by Andrei Kashin on 07.07.2023.
//

import UIKit
import Kingfisher

protocol EditProfileViewControllerProtocol: AnyObject {
    func setData(profile: Profile)
    func showViewController(_ vc: UIViewController)
    func showProgressHUB()
    func dismissProgressHUB()
}

final class EditProfileViewController: UIViewController {
    
    // MARK: - Constants
    
    private enum Constants {
        static let changeAvatarLabelText = Localization.profileChangeAvatarLabelText
        static let loadAvatarLabelText = Localization.profileLoadAvatarLabelText
        static let nameLabelText = Localization.profileNameLabelText
        static let descriptionLabelText = Localization.profileDescriptionLabelText
        static let websiteLabelText = Localization.profileWebsiteLabelText
    }
    
    // MARK: - Properties
    
    private var presenter: EditProfilePresenterProtocol?
    
    // MARK: - Layout elements
    
    private lazy var closeButton: UIButton = {
        let closeButton = UIButton()
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        closeButton.setImage(Image.iconClose.image.withTintColor(Image.appBlack.color), for: .normal)
        closeButton.addTarget(self, action: #selector(closeDidTap), for: .touchUpInside)
        return closeButton
    }()
    
    private lazy var avatarImage: UIImageView = {
        let avatarImage = UIImageView()
        avatarImage.translatesAutoresizingMaskIntoConstraints = false
        avatarImage.layer.cornerRadius = 35
        avatarImage.layer.masksToBounds = true
        return avatarImage
    }()
    
    private lazy var changeAvatarLabel: UILabel = {
        let changeAvatarLabel = UILabel()
        changeAvatarLabel.translatesAutoresizingMaskIntoConstraints = false
        changeAvatarLabel.backgroundColor = .black.withAlphaComponent(0.6)
        changeAvatarLabel.layer.cornerRadius = 35
        changeAvatarLabel.layer.masksToBounds = true
        changeAvatarLabel.text = Constants.changeAvatarLabelText
        changeAvatarLabel.numberOfLines = 0
        changeAvatarLabel.font = .medium10
        changeAvatarLabel.textColor = Image.appWhite.color
        changeAvatarLabel.textAlignment = .center
        let tapAction = UITapGestureRecognizer(target: self, action: #selector(changeAvatarDidTap))
        changeAvatarLabel.isUserInteractionEnabled = true
        changeAvatarLabel.addGestureRecognizer(tapAction)
        return changeAvatarLabel
    }()
    
    private lazy var loadImageLabel: UILabel = {
        let loadImageLabel = UILabel()
        loadImageLabel.translatesAutoresizingMaskIntoConstraints = false
        loadImageLabel.layer.cornerRadius = 16
        loadImageLabel.layer.masksToBounds = true
        loadImageLabel.backgroundColor = Image.appWhite.color
        loadImageLabel.text = Constants.loadAvatarLabelText
        loadImageLabel.font = .regular17
        loadImageLabel.textAlignment = .center
        loadImageLabel.isHidden = true
        return loadImageLabel
    }()
    
    private lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.text = Constants.nameLabelText
        nameLabel.font = .bold22
        nameLabel.textColor = Image.appBlack.color
        return nameLabel
    }()
    
    private lazy var nameTextField: UITextField = {
        let nameTextField = UITextField()
        nameTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: nameTextField.frame.height))
        nameTextField.leftViewMode = .always
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        nameTextField.font = .regular17
        nameTextField.backgroundColor = Image.appLightGrey.color
        nameTextField.layer.cornerRadius = 12
        nameTextField.layer.masksToBounds = true
        nameTextField.clearButtonMode = .whileEditing
        nameTextField.delegate = self
        return nameTextField
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let descriptionLabel = UILabel()
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.text = Constants.descriptionLabelText
        descriptionLabel.font = .bold22
        descriptionLabel.textColor = Image.appBlack.color
        return descriptionLabel
    }()
    
    private lazy var descriptionTextField: UITextField = {
        let descriptionTextField = UITextField()
        descriptionTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: descriptionTextField.frame.height))
        descriptionTextField.leftViewMode = .always
        descriptionTextField.translatesAutoresizingMaskIntoConstraints = false
        descriptionTextField.font = .regular17
        descriptionTextField.backgroundColor = Image.appLightGrey.color
        descriptionTextField.layer.cornerRadius = 12
        descriptionTextField.layer.masksToBounds = true
        descriptionTextField.clearButtonMode = .whileEditing
        descriptionTextField.delegate = self
        return descriptionTextField
    }()
    
    private lazy var websiteLabel: UILabel = {
        let websiteLabel = UILabel()
        websiteLabel.translatesAutoresizingMaskIntoConstraints = false
        websiteLabel.text = Constants.websiteLabelText
        websiteLabel.font = .bold22
        websiteLabel.textColor = Image.appBlack.color
        return websiteLabel
    }()
    
    private lazy var websiteTextField: UITextField = {
        let websiteTextField = UITextField()
        websiteTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: websiteTextField.frame.height))
        websiteTextField.leftViewMode = .always
        websiteTextField.translatesAutoresizingMaskIntoConstraints = false
        websiteTextField.font = .regular17
        websiteTextField.backgroundColor = Image.appLightGrey.color
        websiteTextField.layer.cornerRadius = 12
        websiteTextField.layer.masksToBounds = true
        websiteTextField.clearButtonMode = .whileEditing
        websiteTextField.delegate = self
        return websiteTextField
    }()
    
    // MARK: - Life Cycle
    
    init(presenter: EditProfilePresenterProtocol) {
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
        presenter?.viewIsReady()
    }
    
    // MARK: - Actions
    
    @objc
    private func closeDidTap(_ sender: UIButton) {
        guard let name = nameTextField.text, !name.isEmpty,
              let description = descriptionTextField.text, !description.isEmpty,
              let website = websiteTextField.text, !website.isEmpty
        else { return }
        presenter?.updateProfile(name: name, description: description, website: website)
        dismiss(animated: true)
    }
    
    @objc
    private func changeAvatarDidTap() {
        loadImageLabel.isHidden = false
    }
    
    // MARK: - Layout methods
    
    func showProgressHUB() {
        UIBlockingProgressHUD.show()
    }
    
    func dismissProgressHUB() {
        UIBlockingProgressHUD.dismiss()
    }
    
    func showViewController(_ vc: UIViewController) {
        present(vc, animated: true)
    }
    
    private func setupView() {
        view.backgroundColor = Image.appWhite.color
        view.addSubview(closeButton)
        view.addSubview(avatarImage)
        view.addSubview(changeAvatarLabel)
        view.addSubview(loadImageLabel)
        view.addSubview(nameLabel)
        view.addSubview(nameTextField)
        view.addSubview(descriptionLabel)
        view.addSubview(descriptionTextField)
        view.addSubview(websiteLabel)
        view.addSubview(websiteTextField)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            closeButton.heightAnchor.constraint(equalToConstant: 42),
            closeButton.widthAnchor.constraint(equalToConstant: 42),
            closeButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 30),
            closeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            avatarImage.heightAnchor.constraint(equalToConstant: 70),
            avatarImage.widthAnchor.constraint(equalToConstant: 70),
            avatarImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 94),
            avatarImage.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            
            changeAvatarLabel.heightAnchor.constraint(equalToConstant: 70),
            changeAvatarLabel.widthAnchor.constraint(equalToConstant: 70),
            changeAvatarLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 94),
            changeAvatarLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            
            loadImageLabel.topAnchor.constraint(equalTo: changeAvatarLabel.bottomAnchor, constant: 4),
            loadImageLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadImageLabel.heightAnchor.constraint(equalToConstant: 44),
            loadImageLabel.widthAnchor.constraint(equalToConstant: 250),
            
            nameLabel.topAnchor.constraint(equalTo: avatarImage.bottomAnchor, constant: 24),
            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            nameTextField.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
            nameTextField.heightAnchor.constraint(equalToConstant: 46),
            nameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            nameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            descriptionLabel.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 22),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            descriptionTextField.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 8),
            descriptionTextField.heightAnchor.constraint(equalToConstant: 132),
            descriptionTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            descriptionTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            websiteLabel.topAnchor.constraint(equalTo: descriptionTextField.bottomAnchor, constant: 24),
            websiteLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            websiteTextField.topAnchor.constraint(equalTo: websiteLabel.bottomAnchor, constant: 8),
            websiteTextField.heightAnchor.constraint(equalToConstant: 46),
            websiteTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            websiteTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
    }
}

// MARK: - UITextFieldDelegate

extension EditProfileViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            if touch.view != descriptionTextField &&
                touch.view != nameTextField &&
                touch.view != websiteTextField {
                descriptionTextField.resignFirstResponder()
                nameTextField.resignFirstResponder()
                websiteTextField.resignFirstResponder()
            }
        }
        super.touchesBegan(touches, with: event)
    }
}

// MARK: - UITextViewDelegate

extension EditProfileViewController: EditProfileViewControllerProtocol {
    func setData(profile: Profile) {
        let imageUrlString = profile.avatar
        let imageUrl = URL(string: imageUrlString)
        avatarImage.kf.setImage(
            with: imageUrl,
            placeholder: UIImage(named: "ProfilePhoto"),
            options: [.processor(RoundCornerImageProcessor(cornerRadius: 35))])
        nameTextField.text = profile.name
        descriptionTextField.text = profile.description
        websiteTextField.text = profile.website
    }
}
