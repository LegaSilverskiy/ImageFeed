//
//  ProfileViewControllerProtocol.swift
//  ImageFeed
//
//  Created by Олег Серебрянский on 3/3/24.
//

import Foundation

public protocol ProfileViewControllerProtocol: AnyObject {
    func updateAvatar()
    func updateProfileDetails(profile: Profile?)
    var presenter: ProfileViewPresenterProtocol? { get set }
}
