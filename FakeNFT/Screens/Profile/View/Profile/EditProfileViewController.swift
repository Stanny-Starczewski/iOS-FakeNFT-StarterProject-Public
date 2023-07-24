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
}

final class EditProfileViewController: UIViewController {
    
    // MARK: - Properties
    
    var presenter: EditProfilePresenterProtocol?

    // MARK: - Layout elements
    
    private lazy var closeButton: UIButton = {
        let closeButton = UIButton()
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        closeButton.setImage(UIImage(named: "Close"), for: .normal)
        closeButton.addTarget(self, action: #selector(closeDidTap), for: .touchUpInside)
        return closeButton
    }()
    
    private lazy var avatarImage: UIImageView = {
        let profilePhoto = UIImage(named: "ProfilePhoto")
        let avatarImage = UIImageView(image: profilePhoto)
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
        changeAvatarLabel.text = "Сменить фото"
        changeAvatarLabel.numberOfLines = 0
        changeAvatarLabel.font = .systemFont(ofSize: 10)
        changeAvatarLabel.textColor = .appWhite
        changeAvatarLabel.textAlignment = .center
        let tapAction = UITapGestureRecognizer(target: self, action: #selector(changeAvatarDidTap(_:)))
        changeAvatarLabel.isUserInteractionEnabled = true
        changeAvatarLabel.addGestureRecognizer(tapAction)
        return changeAvatarLabel
    }()
    
    private lazy var loadImageLabel: UILabel = {
        let loadImageLabel = UILabel()
        loadImageLabel.translatesAutoresizingMaskIntoConstraints = false
        loadImageLabel.layer.cornerRadius = 16
        loadImageLabel.layer.masksToBounds = true
        loadImageLabel.backgroundColor = .appWhite
        loadImageLabel.text = "Загрузить изображение"
        loadImageLabel.font = .systemFont(ofSize: 17)
        loadImageLabel.textAlignment = .center
        loadImageLabel.isHidden = true
        return loadImageLabel
    }()
    
    private lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.attributedText = NSAttributedString(string: "Имя", attributes: [.kern: 0.35])
        nameLabel.font = UIFont.boldSystemFont(ofSize: 22)
        nameLabel.textColor = .appBlack
        return nameLabel
    }()
    
    private lazy var nameTextField: UITextField = {
        let nameTextField = UITextField()
        nameTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: nameTextField.frame.height))
        nameTextField.leftViewMode = .always
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        nameTextField.font = .systemFont(ofSize: 17)
        nameTextField.backgroundColor = .appLightGrey
        nameTextField.layer.cornerRadius = 12
        nameTextField.layer.masksToBounds = true
        nameTextField.clearButtonMode = .whileEditing
        nameTextField.placeholder = "Joaquin Phoenix"
        nameTextField.delegate = self
        return nameTextField
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let descriptionLabel = UILabel()
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.attributedText = NSAttributedString(string: "Описание", attributes: [.kern: 0.35])
        descriptionLabel.font = UIFont.boldSystemFont(ofSize: 22)
        descriptionLabel.textColor = .appBlack
        return descriptionLabel
    }()
    
    private lazy var descriptionTextField: UITextField = {
        let descriptionTextField = UITextField()
        descriptionTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: descriptionTextField.frame.height))
        descriptionTextField.leftViewMode = .always
        descriptionTextField.translatesAutoresizingMaskIntoConstraints = false
        descriptionTextField.font = .systemFont(ofSize: 17)
        descriptionTextField.backgroundColor = .appLightGrey
        descriptionTextField.layer.cornerRadius = 12
        descriptionTextField.layer.masksToBounds = true
        descriptionTextField.clearButtonMode = .whileEditing
        descriptionTextField.placeholder = "Описание"
        descriptionTextField.delegate = self
        return descriptionTextField
    }()
    
    private lazy var websiteLabel: UILabel = {
        let websiteLabel = UILabel()
        websiteLabel.translatesAutoresizingMaskIntoConstraints = false
        websiteLabel.attributedText = NSAttributedString(string: "Сайт", attributes: [.kern: 0.35])
        websiteLabel.font = UIFont.boldSystemFont(ofSize: 22)
        websiteLabel.textColor = .appBlack
        return websiteLabel
    }()
    
    private lazy var websiteTextField: UITextField = {
        let websiteTextField = UITextField()
        websiteTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: websiteTextField.frame.height))
        websiteTextField.leftViewMode = .always
        websiteTextField.translatesAutoresizingMaskIntoConstraints = false
        websiteTextField.font = .systemFont(ofSize: 17)
        websiteTextField.backgroundColor = .appLightGrey
        websiteTextField.layer.cornerRadius = 12
        websiteTextField.layer.masksToBounds = true
        websiteTextField.clearButtonMode = .whileEditing
        websiteTextField.placeholder = "JoaquinPhoenix.com"
        websiteTextField.delegate = self
        return websiteTextField
    }()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setConstraints()
        presenter?.setData()
        
    }
    
    // MARK: - Actions
    
    @objc
    private func closeDidTap(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    @objc
    private func changeAvatarDidTap(_ sender: UITapGestureRecognizer) {
        loadImageLabel.isHidden = false
    }
    
    // MARK: - Setup UI
    
    private func setupView() {
        view.backgroundColor = .appWhite
        
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
    
    // MARK: - Setting Constraints
    
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

extension EditProfileViewController: UITextViewDelegate {
    
}

extension EditProfileViewController: EditProfileViewControllerProtocol {
    func setData(profile: Profile) {
        
        //        avatarImage.kf.setImage(
        //            with: profile?.avatarURL,
        //            placeholder: UIImage(named: "ProfilePhoto"),
        //            options: [.processor(RoundCornerImageProcessor(cornerRadius: 35))])
        
        nameTextField.text = profile.name
        descriptionTextField.text = profile.description
        websiteTextField.text = profile.website
        
    }
}
