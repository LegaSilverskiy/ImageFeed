//
//  UserResult.swift
//  ImageFeed
//
//  Created by Олег Серебрянский on 2/13/24.
//

import Foundation

struct UserResult: Codable {
    let profileImage: ProfileImage
}

struct ProfileImage: Codable {
    let small: String
    let medium: String
    let large: String
}
