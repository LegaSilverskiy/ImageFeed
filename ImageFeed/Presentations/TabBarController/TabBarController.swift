//
//  TabBarController.swift
//  ImageFeed
//
//  Created by Олег Серебрянский on 2/19/24.
//

import Foundation
import UIKit

final class TabBarController: UITabBarController {
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        let imagesListViewController = storyboard.instantiateViewController(withIdentifier: "ImagesListViewController") as! ImagesListViewController
        let presenter = ImageListViewPresenter()
        imagesListViewController.configure(presenter: presenter)

        let profileViewController = ProfileViewController()
        let profileViewPresenter = ProfileViewPresenter()
        profileViewController.configure(presenter: profileViewPresenter)
        
        profileViewController.tabBarItem = UITabBarItem(
            title: nil,
            image: UIImage(named: "tab_profile_active"),
            selectedImage: nil)
        
        self.viewControllers = [imagesListViewController, profileViewController]
    }
}
