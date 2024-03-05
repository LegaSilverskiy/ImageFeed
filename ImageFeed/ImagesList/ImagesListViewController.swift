//
//  ViewController.swift
//  ImageFeed
//
//  Created by Олег Серебрянский on 11/30/23.
//

import UIKit
import Kingfisher

class ImagesListViewController: UIViewController, ImagesListViewControllerProtocol {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @IBOutlet private var tableView: UITableView!
    
    var presenter: ImagesListViewPresenterProtocol?
    //MARK: private properties
    private let showSingleImageSegueIdentifier = "ShowSingleImage"
    private let imageListService = ImageListService.shared
    // MARK: - View Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpTable()
        presenter?.addObserver()
        presenter?.loadingPhotos()
    }
    //TODO: Remove force in method
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == showSingleImageSegueIdentifier {
            if let vc = segue.destination as? SingleImageViewController,
               let indexpath = sender as? IndexPath,
               let imageURL = presenter?.photos[indexpath.row].largeImageURL {
                vc.fullImageURL = URL(string: imageURL)
            }
        } else {
            super.prepare(for: segue, sender: sender)
        }
    }
}
    //MARK: Extensions
extension ImagesListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.photos.count ?? 0
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
    private func configCell(for cell: ImagesListCell, with indexPath: IndexPath) {
        cell.delegate = self
        let image = presenter?.avatarUrl(indexPath: indexPath)
        cell.cellImage.kf.setImage(with: image, placeholder: UIImage(named: "imagePlaceholder"))
        cell.dateLabel.text = presenter?.dateLabel(indexPath: indexPath)
        let likeImage = presenter?.likeImage(indexPath: indexPath)
        cell.likeButton.setImage(likeImage, for: .normal)
    }
    private func setUpTable() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.contentInset = UIEdgeInsets(top: 12, left: 0, bottom: 12, right: 0)
    }
}

extension ImagesListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        presenter?.loadingNextPage(indexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: showSingleImageSegueIdentifier, sender: indexPath)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let result = presenter?.letsCountHeight(tableView, heightForRowAt: indexPath) else {
            return 0.0 }
        return result
    }
    func updateTableViewAnimated() {
        tableView.performBatchUpdates {
            guard let newIndex = presenter?.updateListModel() else { return }
            tableView.insertRows(at: newIndex, with: .automatic)
        } completion: { _ in }
    }
}

extension ImagesListViewController: ImageListCellDelegate {
    func imageListCellDidTapLike(_ cell: ImagesListCell) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        presenter?.didTapLike(cell: cell, indexPath: indexPath)
    }
}

extension ImagesListViewController {
    func setIsLoading(_ isLoading: ProgressStatus) {
        switch isLoading {
        case .show: UIBlockingProgressHUD.show()
        case .dismiss: UIBlockingProgressHUD.dismiss()
        case .like: UIBlockingProgressHUD.like()
        case .dislike: UIBlockingProgressHUD.dislike()
        }
    }
}
extension ImagesListViewController {
    func configure(presenter: ImagesListViewPresenterProtocol?) {
        self.presenter = presenter
        self.presenter?.viewController = self
    }
    
}
