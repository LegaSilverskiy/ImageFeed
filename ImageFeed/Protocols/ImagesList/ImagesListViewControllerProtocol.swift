//
//  ImageListViewControllerProtocol.swift
//  ImageFeed
//
//  Created by Олег Серебрянский on 3/3/24.
//

import Foundation
import UIKit

public protocol ImagesListViewControllerProtocol: AnyObject {
    var presenter: ImagesListViewPresenterProtocol? { get set }
    
    func updateTableViewAnimated()
    func setIsLoading(_ isLoading: ProgressStatus)
}
