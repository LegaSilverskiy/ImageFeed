//
//  ProfileViewPresenterProtocol.swift
//  ImageFeed
//
//  Created by Олег Серебрянский on 3/3/24.
//

import Foundation
import UIKit

public protocol ProfileViewPresenterProtocol {
    func showAlert() -> UIAlertController
    func logout()
    func updateProfileImage() -> URL?
    func addObserver()
    
    var viewController: ProfileViewControllerProtocol? { get set }
}
