//
//  ProfileController.swift
//  ImageFeed
//
//  Created by Олег Серебрянский on 12/18/23.
//

import Foundation
import UIKit

final class ProfileViewController: UIViewController {


    let profileImage = UIImage(named: "avatar")
    
    override func viewDidLoad() {
        
        let profileIcon = UIImageView()
        view.addSubview(profileIcon)
        profileIcon.translatesAutoresizingMaskIntoConstraints = false
        profileIcon.image = profileImage
        profileIcon.tintColor = .gray
        profileIcon.layer.cornerRadius = profileIcon.frame.size.width / 2
        profileIcon.clipsToBounds = true
        
        let labelName = UILabel()
        view.addSubview(labelName)
        labelName.translatesAutoresizingMaskIntoConstraints = false
        labelName.text = "Екатерина Новикова"
        labelName.textColor = .ypWhiteIOS
        
        let logoutButton = UIButton(type: .custom)
        view.addSubview(logoutButton)
        logoutButton.translatesAutoresizingMaskIntoConstraints = false
        logoutButton.tintColor = .red
        logoutButton.setImage(UIImage(named: "ExitButton"), for: .normal)
        
        let labelLogin = UILabel()
        view.addSubview(labelLogin)
        labelLogin.translatesAutoresizingMaskIntoConstraints = false
        labelLogin.text = "@ekaterina_nov"
        labelLogin.textColor = .ypGrayIOS
        
        let labelDescription = UILabel()
        view.addSubview(labelDescription)
        labelDescription.translatesAutoresizingMaskIntoConstraints = false
        labelDescription.text = "Hello, world!"
        labelDescription.textColor = .ypWhiteIOS
        labelDescription.numberOfLines = 0
        
        
        
        NSLayoutConstraint.activate([
        profileIcon.widthAnchor.constraint(equalToConstant: 70),
        profileIcon.heightAnchor.constraint(equalToConstant: 70),
        profileIcon.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32),
        profileIcon.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
        labelName.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
        labelName.topAnchor.constraint(equalTo: profileIcon.bottomAnchor, constant: 8),
        labelName.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -8),
        labelLogin.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
        labelLogin.topAnchor.constraint(equalTo: labelName.bottomAnchor, constant: 8),
        labelLogin.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -8),
        labelDescription.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
        labelDescription.topAnchor.constraint(equalTo: labelLogin.bottomAnchor, constant: 8),
        labelDescription.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -8),
        logoutButton.centerYAnchor.constraint(equalTo: profileIcon.safeAreaLayoutGuide.centerYAnchor),
        logoutButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
        logoutButton.widthAnchor.constraint(equalToConstant: 44),
        logoutButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
}
