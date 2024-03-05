//
//  WebViewViewControllerProtocol.swift
//  ImageFeed
//
//  Created by Олег Серебрянский on 3/1/24.
//

import Foundation

public protocol WebViewViewControllerProtocol: AnyObject {
    var presenter: WebViewPresenterProtocol? { get set }
    func load(request: URLRequest)
    func setProgressValue(_ newValue: Float)
    func setProgressHidden(_ isHidden: Bool)
}
