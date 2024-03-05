//
//  AuthHelperProtocol.swift
//  ImageFeed
//
//  Created by Олег Серебрянский on 3/2/24.
//

import Foundation

protocol AuthHelperProtocol {
    func authRequest() -> URLRequest?
    func code(from url: URL) -> String?
} 
