//
//  WebViewPresenterProtocol.swift
//  ImageFeed
//
//  Created by Олег Серебрянский on 3/1/24.
//

import Foundation

public protocol WebViewPresenterProtocol {
    var view: WebViewViewControllerProtocol? { get set }
    func didUpdateProgressValue(_ newValue: Double)
    func code(from url: URL) -> String?
    func viewDidLoad()
}
