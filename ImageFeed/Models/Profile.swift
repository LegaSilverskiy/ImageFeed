//
//  Profile.swift
//  ImageFeed
//
//  Created by Олег Серебрянский on 2/12/24.
//

import Foundation


public struct Profile {
    let userName: String
    public let name: String
    public let loginName: String
    let bio: String?
    
    init(from result: ProfileResult) {
        self.userName = result.username
        self.name = result.firstName + " " + result.lastName
        self.loginName = "@" + result.username
        self.bio = result.bio
    }
}
