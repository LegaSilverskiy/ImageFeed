//
//  ViewController.swift
//  ImageFeed
//
//  Created by Олег Серебрянский on 11/30/23.
//

import UIKit
import Kingfisher

class ImagesListViewController: UIViewController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @IBOutlet private var tableView: UITableView!
    //MARK: private properties
//    private let photosName: [String] = Array(0..<20).map{ "\($0)" }
    private let showSingleImageSegueIdentifier = "ShowSingleImage"
    private var photos: [Photo] = []
    private var photoServiceObserver: NSObjectProtocol?
    private let imageListService = ImageListService.shared
    // MARK: - View Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.contentInset = UIEdgeInsets(top: 12, left: 0, bottom: 12, right: 0)
        
        if photos.isEmpty {
            UIBlockingProgressHUD.show()
            guard let token = OAuth2TokenStorage().token else {
                print("Токен не получен")
                return
            }
            imageListService.fetchPhotosNextPage(token: token)
            UIBlockingProgressHUD.dismiss()
        }
        
        photoServiceObserver = NotificationCenter.default.addObserver(
            forName: ImageListService.didChangeNotification,
            object: nil,
            queue: .main,
            using: { [weak self] _ in
                guard let self = self else { return }
                self.updateTableViewAnimated()
            }
        )
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == showSingleImageSegueIdentifier {
            let vc = segue.destination as! SingleImageViewController
            let indexpath = sender as! IndexPath
            let imageURL = photos[indexpath.row].largeImageURL
            vc.fullImageURL = URL(string: imageURL)
        } else {
            super.prepare(for: segue, sender: sender)
        }
    }

    private lazy var dateFormatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateFormat = "dd MMMM yyyy"
            formatter.locale = Locale(identifier: "ru_RU")
            return formatter
        }()
}
    //MARK: Extensions
extension ImagesListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photos.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ImagesListCell.reuseIdentifier, for: indexPath)
        
        guard let imageListCell = cell as? ImagesListCell else {
            return UITableViewCell()
        }
        
        configCell(for: imageListCell, with: indexPath)
        return imageListCell
    }
}


extension ImagesListViewController {
    func configCell(for cell: ImagesListCell, with indexPath: IndexPath) {
        
        cell.delegate = self
        
        let imageURL = photos[indexPath.row].thumbImageURL
        guard let image = URL(string: imageURL) else {
            print("Пришлa пустая ссылка")
            return
        }
        cell.cellImage.kf.setImage(with: image, placeholder: UIImage(named: "placeholderForImages"))
        
        if let createdDate = photos[indexPath.row].createdAt {
            cell.dateLabel.text = dateFormatter.string(from: createdDate)
        } else {
            cell.dateLabel.text = ""
        }
        
        let likeImage = photos[indexPath.row].isLiked ? UIImage(named: "likeImageActive") : UIImage(named: "likeImageNoActive")
        cell.likeButton.setImage(likeImage, for: .normal)

    }
}

extension ImagesListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row + 1 == photos.count {
            imageListService.fetchPhotosNextPage(token: OAuth2TokenStorage().token!)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: showSingleImageSegueIdentifier, sender: indexPath)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let image = photos[indexPath.row]
        let cellIns = UIEdgeInsets(top: 4, left: 16, bottom: 4, right: 16)
        let cellWigth = tableView.bounds.width - cellIns.left - cellIns.right
        let imageWidth = image.size.width
        let sizeRatio = cellWigth / imageWidth
        let cellHeight = image.size.height * sizeRatio + cellIns.top + cellIns.bottom
        
        return cellHeight
    }
    func updateTableViewAnimated() {
        let oldCount = photos.count
        let newCount = imageListService.photos.count
        photos = imageListService.photos
        if oldCount != newCount {
            tableView.performBatchUpdates {
                let indexPaths = (oldCount..<newCount).map { i in
                    IndexPath(row: i, section: 0)
                }
                tableView.insertRows(at: indexPaths, with: .automatic)
            } completion: { _ in }
        }
    }
}

extension ImagesListViewController: ImageListCellDelegate {
    func imageListCellDidTapLike(_ cell: ImagesListCell) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        let photo = photos[indexPath.row]
        photo.isLiked ? UIBlockingProgressHUD.dislike() : UIBlockingProgressHUD.like()
        imageListService.changeLike(photoId: photo.id, isLike: !photo.isLiked) { result in
            switch result {
            case .success:
                self.photos = self.imageListService.photos
                let likeImage = self.photos[indexPath.row].isLiked ? UIImage(named: "likeImageActive") : UIImage(named: "likeImageNoActive")
                cell.likeButton.setImage(likeImage, for: .normal)
                UIBlockingProgressHUD.dismiss()
            case .failure:
                UIBlockingProgressHUD.dismiss()
            }
        }
    }
}

