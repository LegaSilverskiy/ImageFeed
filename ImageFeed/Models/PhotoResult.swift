//
//  PhotoResult.swift
//  ImageFeed
//
//  Created by Олег Серебрянский on 2/21/24.
//

import Foundation

struct PhotoResult: Decodable {
    let id: String
    let likedByUser: Bool
    let createdAt: String
    let width, height: Int
    let description: String?
    let urls: UrlsResult
    
    enum CodingKeys: String, CodingKey {
        case id, width, height, description, urls
        case createdAt = "created_at"
        case likedByUser = "liked_by_user"
    }
}
