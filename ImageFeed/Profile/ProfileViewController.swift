//
//  ProfileController.swift
//  ImageFeed
//
//  Created by Олег Серебрянский on 12/18/23.
//

import Foundation
import UIKit
import Kingfisher

final class ProfileViewController: UIViewController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // MARK: - Private properties
    private lazy var avatarImageSize = 70.0
    private lazy var profileIcon: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "avatar")
        image.tintColor = .gray
        image.layer.cornerRadius = avatarImageSize / 2
        image.clipsToBounds = true
        return image
    }()
    
    private lazy var labelName: UILabel = {
        let label = UILabel()
        label.text = "Екатерина Новикова"
        label.textColor = .ypWhiteIOS
        label.font = UIFont.systemFont(ofSize: 23, weight: .bold)
        return label
    }()
    
    private lazy var labelLogin: UILabel = {
        let label = UILabel()
        label.text = "@ekaterina_nov"
        label.textColor = .ypGrayIOS
        label.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        return label
    }()
    
    private lazy var labelDescription: UILabel = {
        let label = UILabel()
        label.text = "Hello, world!"
        label.textColor = .ypWhiteIOS
        label.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        return label
    }()
    
    private lazy var logoutButton: UIButton = {
        let buttonImage = UIImage(named: "ExitButton")
        guard let buttonImage = buttonImage else {return UIButton()}
        
        let button = UIButton.systemButton(with: buttonImage,
                                           target: self,
                                           action: #selector(buttonTapped(_ :)))
        button.tintColor = .ypRedIOS
        return button
    }()
    
    private let profileService = ProfileService.shared
    private let profileImageService = ProfileImageService.shared
    private var profileImageServiceObserver: NSObjectProtocol?
    
    // MARK: - View Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .ypBlackIOS
        
        profileImageServiceObserver = NotificationCenter.default.addObserver(
            forName: ProfileImageService.didChangeNotification,
            object: nil,
            queue: .main
        ) { [weak self] _ in
            guard let self = self else { return }
            self.updateProfileImage()
        }
        
        updateProfileDetails(profile: profileService.profile)
        updateProfileImage()
        
        view.addSubview(profileIcon)
        view.addSubview(labelName)
        view.addSubview(logoutButton)
        view.addSubview(labelLogin)
        view.addSubview(labelDescription)
        
        profileIcon.translatesAutoresizingMaskIntoConstraints = false
        labelName.translatesAutoresizingMaskIntoConstraints = false
        logoutButton.translatesAutoresizingMaskIntoConstraints = false
        labelLogin.translatesAutoresizingMaskIntoConstraints = false
        labelDescription.translatesAutoresizingMaskIntoConstraints = false
        
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

    @objc private func buttonTapped(_ sender: UIButton) {

    }
    
    private func updateProfileDetails(profile: Profile?) {
        guard let profile = profile else {
            return }
        labelName.text = profile.name
        labelLogin.text = profile.loginName
        labelDescription.text = profile.bio
        
    }

    private func updateProfileImage() {
        guard let imageURL = ProfileImageService.shared.profileImageURL,
              let avatarURL = URL(string: imageURL) else { fatalError("Пришлa пустая ссылка на аватарку")}
        
        profileIcon.kf.setImage(with: avatarURL, placeholder: UIImage(named: "placeholder"))
    }
}
