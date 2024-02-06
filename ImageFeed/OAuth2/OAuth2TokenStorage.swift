//
//  OAuth2TokenStorage.swift
//  ImageFeed
//
//  Created by Олег Серебрянский on 1/22/24.
//

import Foundation

final class OAuth2TokenStorage {
    
    var token: String? {
        get {
            return UserDefaults.standard.string(forKey: key)
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: key)
        }
    }
    
    private let key = "bearerToken"
}
