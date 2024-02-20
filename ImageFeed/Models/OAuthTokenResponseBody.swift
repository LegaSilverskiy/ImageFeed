//
//  OAuthTokenResponseBody.swift
//  ImageFeed
//
//  Created by Олег Серебрянский on 2/3/24.
//

import Foundation

    struct OAuthTokenResponseBody: Decodable {
    let accessToken: String
    let tokenType: String
    let scope: String
    let createdAt: Int
}
