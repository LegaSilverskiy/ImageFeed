//
//  OAuth2TokenStorage.swift
//  ImageFeed
//
//  Created by Олег Серебрянский on 1/22/24.
//

import Foundation
import SwiftKeychainWrapper

final class OAuth2TokenStorage {
    
    // MARK: - Public properties
    var token: String? {
        get {
            return keyWrapper.string(forKey: key)
        }
        set {
            if let newValue = newValue {
            keyWrapper.set(newValue, forKey: key)
            } else { fatalError("Error with keyChain")}
        }
    }
    
    // MARK: - Private properties
    private let key = "bearerToken"
    private let keyWrapper = KeychainWrapper.standard
}

