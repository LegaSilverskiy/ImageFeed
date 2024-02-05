//
//  NetworkClient.swift
//  ImageFeed
//
//  Created by Олег Серебрянский on 1/29/24.
//

import Foundation

enum NetworkError: Error {
    case httpStatusCode(Int)
    case urlRequestError(Error)
    case urlSessionError
}

