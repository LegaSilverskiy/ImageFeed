//
//  ImagesListViewPresenter.swift
//  ImageFeed
//
//  Created by Олег Серебрянский on 3/3/24.
//

import Foundation
import UIKit

final class ImageListViewPresenter: ImagesListViewPresenterProtocol {
    
    weak var viewController: ImagesListViewControllerProtocol?
    
    var photos: [Photo] = []
    private let imageListService = ImageListService.shared
    
    private lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .none
        formatter.dateFormat = "d MMMM yyyy"
        return formatter
    }()
    
    func updateListModel() -> [IndexPath]? {
        let oldCount = photos.count
        let newCount = imageListService.photos.count
        photos = imageListService.photos
        if oldCount != newCount {
            let newIndexPaths = (oldCount..<newCount).map { IndexPath(row: $0, section: 0) }
            return newIndexPaths
        }
        return nil
    }
    
    func loadingPhotos() {
        if photos.isEmpty {
            UIBlockingProgressHUD.show()
            guard OAuth2TokenStorage().token != nil else {
                print("Problem with token")
                return
            }
            imageListService.fetchPhotosNextPage()
            UIBlockingProgressHUD.dismiss()
        }
    }
    
    
    func addObserver() {
        NotificationCenter.default.addObserver(
            forName: ImageListService.didChangeNotification,
            object: nil,
            queue: .main,
            using: { [weak self] _ in
                guard let self = self else { return }
                viewController?.updateTableViewAnimated()
            })
    }
    
    func didTapLike(cell: ImagesListCell, indexPath: IndexPath) {
        let photo = photos[indexPath.row]
        photo.isLiked ? viewController?.setIsLoading(.dislike) : viewController?.setIsLoading(.like)
        imageListService.changeLike(photoId: photo.id, isLike: !photo.isLiked) { result in
            switch result {
            case .success:
                self.photos = self.imageListService.photos
                let likeImage = self.likeImage(indexPath: indexPath)
                cell.likeButton.setImage(likeImage, for: .normal)
                self.viewController?.setIsLoading(.dismiss)
            case .failure:
                self.viewController?.setIsLoading(.dismiss)
            }
        }
    }
    
    
    
    
    
    func letsCountHeight(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let image = photos[indexPath.row]
        let cellIns = UIEdgeInsets(top: 4, left: 16, bottom: 4, right: 16)
        let cellWigth = tableView.bounds.width - cellIns.left - cellIns.right
        let imageWidth = image.size.width
        let sizeRatio = cellWigth / imageWidth
        let cellHeight = image.size.height * sizeRatio + cellIns.top + cellIns.bottom
        
        return cellHeight
    }
    
    
    func avatarUrl(indexPath: IndexPath) -> URL? {
        let imageURL = photos[indexPath.row].thumbImageURL
        if let image = URL(string: imageURL) {
            return image
        } else {
            print("Empty URL")
            return nil
        }
    }
    
    func dateLabel(indexPath: IndexPath) -> String? {
        if let createdDate = photos[indexPath.row].createdAt {
            return dateFormatter.string(from: createdDate)
        } else {
            return ""
        }
    }
    
    func likeImage(indexPath: IndexPath) -> UIImage? {
        if photos[indexPath.row].isLiked {
            return UIImage(named: "likeImageActive")
        } else {
            return UIImage(named: "likeImageNoActive")
        }
    }
    
    func loadingNextPage(indexPath: IndexPath) {
        if indexPath.row + 1 == photos.count {
            imageListService.fetchPhotosNextPage()
        }
    }
}
