//
//  ProfileViewPresenterSpy.swift
//  ImageFeedTests
//
//  Created by Олег Серебрянский on 3/3/24.
//

import ImageFeed
import Foundation
import UIKit

final class ProfileViewPresenterSpy: ProfileViewPresenterProtocol {
    
    var updateProfileImageCalled: Bool = false
    var buttonDidTapped: Bool = false
    var observer: Bool = false
    var viewController: ProfileViewControllerProtocol?
    
    func showAlert() -> UIAlertController {
        logout()
        return UIAlertController()
    }
    
    func logout() {
        buttonDidTapped = true
    }
    
    func updateProfileImage() -> URL? {
        updateProfileImageCalled = true
        return nil
    }
    
    func addObserver() {
        observer = true
    }
}
