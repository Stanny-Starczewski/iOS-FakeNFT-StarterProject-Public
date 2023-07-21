//
//  EditProfilePresenter.swift
//  FakeNFT
//
//  Created by Andrei Kashin on 19.07.2023.
//

import Foundation

protocol EditProfilePresenterProtocol: AnyObject {
    func fetchModel() -> Profile
}

final class EditProfilePresenter: EditProfilePresenterProtocol {
    
    private var profileResult: Profile
    private var editProfileViewController: EditProfileViewControllerProtocol?
    
    init(profileResult: Profile, editProfileViewController: EditProfileViewControllerProtocol? = nil) {
        self.profileResult = profileResult
        self.editProfileViewController = editProfileViewController
    }
    
    func fetchModel() -> Profile {
        return profileResult
    }
    
}
