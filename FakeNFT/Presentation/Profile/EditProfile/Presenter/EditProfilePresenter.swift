//
//  EditProfilePresenter.swift
//  FakeNFT
//
//  Created by Andrei Kashin on 19.07.2023.
//

import Foundation

protocol EditProfilePresenterProtocol: AnyObject {
    init(view: EditProfileViewControllerProtocol, profile: Profile, delegate: EditProfileDelegate)
    func setData()
    func updateProfile(name: String, description: String, website: String)
}

protocol EditProfileDelegate: AnyObject {
    func updateProfile(_ profile: Profile)
}

final class EditProfilePresenter: EditProfilePresenterProtocol {
    
    // MARK: - Properties
    
    var profile: Profile
    weak var view: EditProfileViewControllerProtocol?
    private weak var delegate: EditProfileDelegate?
    
    // MARK: - Init
    
    init(view: EditProfileViewControllerProtocol, profile: Profile, delegate: EditProfileDelegate) {
        self.view = view
        self.profile = profile
        self.delegate = delegate
    }
    
    // MARK: - Methods
    
    public func setData() {
        self.view?.setData(profile: profile)
    }
    
    public func updateProfile(name: String, description: String, website: String) {
        let profile = Profile(
            name: name,
            avatar: profile.avatar,
            description: description,
            website: website,
            nfts: profile.nfts,
            likes: profile.likes,
            id: profile.id
        )
        delegate?.updateProfile(profile)
        let networkClient = DefaultNetworkClient()
        let request = PutProfileRequest(dto: profile)
        view?.showProgressHUB()
        networkClient.send(request: request, type: Profile.self) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let profile):
                    print(profile)
                    self?.view?.dismissProgressHUB()
                case .failure(let error):
                    print(error)
                    self?.view?.dismissProgressHUB()
                }
            }
        }
    }
}
