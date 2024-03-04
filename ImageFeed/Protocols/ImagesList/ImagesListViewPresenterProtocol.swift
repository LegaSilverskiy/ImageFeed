//
//  ImageListViewPresenterProtocol.swift
//  ImageFeed
//
//  Created by Олег Серебрянский on 3/3/24.
//

import Foundation
import UIKit

public protocol ImagesListViewPresenterProtocol {
    
    var viewController: ImagesListViewControllerProtocol? { get set }
    var photos: [Photo] { get set }
    
    func addObserver()
    func loadingPhotos()
    func letsCountHeight(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    func loadingNextPage(indexPath: IndexPath)
    func avatarUrl(indexPath: IndexPath) -> URL?
    func dateLabel(indexPath: IndexPath) -> String?
    func likeImage(indexPath: IndexPath) -> UIImage?
    func didTapLike(cell: ImagesListCell, indexPath: IndexPath)
    func updateListModel() -> [IndexPath]?
}
