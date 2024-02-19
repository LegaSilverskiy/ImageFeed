//
//  ProfileResult.swift
//  ImageFeed
//
//  Created by Олег Серебрянский on 2/12/24.
//

import Foundation

struct ProfileResult: Decodable {
    let username: String
    let firstName: String
    let lastName: String
    let bio: String?
}
