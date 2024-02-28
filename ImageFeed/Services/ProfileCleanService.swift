//
//  ProfileCleanService.swift
//  ImageFeed
//
//  Created by Олег Серебрянский on 2/26/24.
//

import Foundation
import WebKit

final class ProfileCleanService {
    static let shared = ProfileCleanService()
    func cleanCookies() {
       HTTPCookieStorage.shared.removeCookies(since: Date.distantPast)
       WKWebsiteDataStore.default().fetchDataRecords(ofTypes: WKWebsiteDataStore.allWebsiteDataTypes()) { records in
          records.forEach { record in
             WKWebsiteDataStore.default().removeData(ofTypes: record.dataTypes, for: [record], completionHandler: {})
          }
       }
    }
    
}
