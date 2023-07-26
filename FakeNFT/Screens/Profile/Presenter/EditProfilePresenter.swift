//
//  EditProfilePresenter.swift
//  FakeNFT
//
//  Created by Andrei Kashin on 19.07.2023.
//

import Foundation

protocol EditProfilePresenterProtocol: AnyObject {
    init(view: EditProfileViewControllerProtocol, profile: Profile)
    func setData()
}

final class EditProfilePresenter: EditProfilePresenterProtocol {
    
    // MARK: - Properties
    
    var profile: Profile
    weak var view: EditProfileViewControllerProtocol?
    
    // MARK: - Init
    
    init(view: EditProfileViewControllerProtocol, profile: Profile) {
        self.view = view
        self.profile = profile
    }
    
    // MARK: - Methods
    
    public func setData() {
        self.view?.setData(profile: profile)
    }
    
    //    public func putProfileData(name: String, avatar: String, description: String, website: String) {
    //        UIBlockingProgressHUD.show()
    //
    //      //  print(name, avatar, description, website)
    //
    //        let networkClient = DefaultNetworkClient()
    //
    //        let request = PutProfileRequest(
    //            name: name,
    //            avatar: avatar,
    //            description: description,
    //            website: website
    //        )
    //
    //        networkClient.send(request: request, type: ProfilePut.self) { [weak self] result in
    //            DispatchQueue.main.async {
    //                switch result {
    //                case .success(let profile):
    //                    print(profile)
    //                    self?.fillSelfFromResponse(response: profile)
    //                    UIBlockingProgressHUD.dismiss()
    //                case .failure(let error):
    //                    print(error)
    //                    UIBlockingProgressHUD.dismiss()
    //                }
    //            }
    //        }
    //    }
    //
    //    func fillSelfFromResponse(response: ProfilePut) {
    //        self.avatarURL = URL(string: response.avatar)
    //        self.name = response.name
    //        self.description = response.description
    //        self.website = response.website
    //     //   self.id = response.id
    //    }
}
