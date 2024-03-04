//
//  ProfileViewControllerSpy.swift
//  ImageFeedTests
//
//  Created by Олег Серебрянский on 3/3/24.
//

import ImageFeed
import Foundation

final class ProfileViewControllerSpy: ProfileViewControllerProtocol {
    
    var nameLabel: String?
    var nicknameLabel: String?
    
    func updateProfileDetails(profile: ImageFeed.Profile?) {
        if let profile = profile {
            self.nameLabel = profile.name
            self.nicknameLabel = profile.loginName
        }
    }
    
    
    func updateAvatar() {
        
    }
    
    var presenter: ImageFeed.ProfileViewPresenterProtocol?
}
