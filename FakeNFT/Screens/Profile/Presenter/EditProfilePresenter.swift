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
    
    var profile: Profile
    weak var view: EditProfileViewControllerProtocol?
    
    init(view: EditProfileViewControllerProtocol, profile: Profile) {
        self.view = view
        self.profile = profile

    }
    
    public func setData() {
        self.view?.setData(profile: profile)
    }
}
