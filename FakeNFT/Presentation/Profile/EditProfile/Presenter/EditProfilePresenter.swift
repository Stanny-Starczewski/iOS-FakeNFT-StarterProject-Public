//
//  EditProfilePresenter.swift
//  FakeNFT
//
//  Created by Andrei Kashin on 19.07.2023.
//

import Foundation

protocol EditProfilePresenterProtocol: AnyObject {
    func viewIsReady()
    func updateProfile(name: String, description: String, website: String)
}

protocol EditProfileDelegate: AnyObject {
    func updateProfile(_ profile: Profile)
}

final class EditProfilePresenter: EditProfilePresenterProtocol {
    
    // MARK: - Properties
    
    weak var view: EditProfileViewControllerProtocol?
    private var profile: Profile
    private weak var delegate: EditProfileDelegate?
    private var networkService: NetworkServiceProtocol
    private var alertBuilder: AlertBuilderProtocol
    
    // MARK: - Init
    
    init(
        profile: Profile,
        networkService: NetworkServiceProtocol,
        alertBuilder: AlertBuilderProtocol,
        delegate: EditProfileDelegate
    ) {
        self.profile = profile
        self.delegate = delegate
        self.networkService = networkService
        self.alertBuilder = alertBuilder
    }
    
    // MARK: - Methods
    
    public func viewIsReady() {
        view?.setData(profile: profile)
    }
    
    public func updateProfile(name: String, description: String, website: String) {
        let newProfile = Profile(
            name: name,
            avatar: profile.avatar,
            description: description,
            website: website,
            nfts: profile.nfts,
            likes: profile.likes,
            id: profile.id
        )
        
        delegate?.updateProfile(newProfile)
        
        networkService.updateProfile(profile: newProfile) { [weak self] error in
            guard let self else { return }
            if let error {
                view?.dismissProgressHUB()
                let alert = self.alertBuilder.makeErrorAlert(with: error.localizedDescription)
                self.view?.showViewController(alert)
            }
        }
    }
}
