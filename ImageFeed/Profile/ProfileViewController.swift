//
//  ProfileController.swift
//  ImageFeed
//
//  Created by Олег Серебрянский on 12/18/23.
//

import UIKit
import Kingfisher
import WebKit
import SwiftKeychainWrapper

final class ProfileViewController: UIViewController & ProfileViewControllerProtocol {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    // MARK: - Public properties
    var presenter: ProfileViewPresenterProtocol?
    
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
    // MARK: - View Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .ypBlackIOS
        
        presenter?.addObserver()
        updateProfileDetails(profile: profileService.profile)
        updateAvatar()
        
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
        
        logoutButton.accessibilityIdentifier = "logoutButton"
        profileIcon.accessibilityIdentifier = "profileIcon"
        labelName.accessibilityIdentifier = "labelName"
        labelLogin.accessibilityIdentifier = "labelLogin"
        labelDescription.accessibilityIdentifier = "labelDescription"
        
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
        //MARK: Actions
    @objc private func buttonTapped(_ sender: UIButton) {
        if let alert = presenter?.showAlert() {
            self.present(alert, animated: true)
        }
    }
    
    func updateProfileDetails(profile: Profile?) {
        if let profile = profile {
            labelName.text = profile.name
            labelLogin.text = profile.loginName
            labelDescription.text = profile.bio
        } else {
            print("Не смогли получить данные профиля")
            return }
    }
    
    
    func updateAvatar() {
        let avatar = presenter?.updateProfileImage()
        self.profileIcon.kf.setImage(with: avatar, placeholder: UIImage(named: "placeholder"))

    }
    
    
    // MARK: - Public Methods
    func configure(presenter: ProfileViewPresenterProtocol?) {
        self.presenter = presenter
        self.presenter?.viewController = self
    }
}
