//
//  SingleImageViewController.swift
//  ImageFeed
//
//  Created by Олег Серебрянский on 12/24/23.
//

import UIKit
import ProgressHUD
import Kingfisher

final class SingleImageViewController: UIViewController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    //MARK: Public properties
    var image: UIImage! = UIImage(named: "placeholderForImages") {
        didSet {
            guard isViewLoaded else { return }
            imageView.image = image
            rescaleAndCenterImageInScrollView(image: image)
        }
    }
    var fullImageURL: URL?
    
    //MARK: IB Outlets
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet var imageView: UIImageView!
    
    //MARK: Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.image = image
        
        if fullImageURL != nil {
            downloadImage()
        }
    }
    private func rescaleAndCenterImageInScrollView(image: UIImage) {
        scrollView.minimumZoomScale = 0.1
        scrollView.maximumZoomScale = 1.25
        let minZoomScale = scrollView.minimumZoomScale
        let maxZoomScale = scrollView.maximumZoomScale
        view.layoutIfNeeded()
        let visibleRectSize = scrollView.bounds.size
        let imageSize = image.size
        let hScale = visibleRectSize.width / imageSize.width
        let vScale = visibleRectSize.height / imageSize.height
        let scale = min(maxZoomScale, max(minZoomScale, max(hScale, vScale)))
        scrollView.setZoomScale(scale, animated: true)
        scrollView.layoutIfNeeded()
        let newContentSize = self.scrollView.contentSize
        let x = (newContentSize.width - visibleRectSize.width) / 2
        let y = (newContentSize.height - visibleRectSize.height) / 2
        scrollView.setContentOffset(CGPoint(x: x, y: y), animated: false)
    }
    
    @IBAction func didTapBackButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func didTapShareButton(_ sender: UIButton) {
        let share = UIActivityViewController(
            activityItems: [image as Any],
            applicationActivities: nil
        )
        present(share, animated: true, completion: nil)
    }
}

    //MARK: Extensions
extension SingleImageViewController: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        imageView
    }

}

extension SingleImageViewController {
    private func downloadImage() {
        if let fullImageURL = fullImageURL {
            Kingfisher.ImageDownloader.default.downloadImage(
                with: fullImageURL,
                progressBlock: { receivedSize, totalSize in
                    let progress = Float(receivedSize) / Float(totalSize)
                    UIBlockingProgressHUD.show()
                })  { [weak self] result in
                    guard let self = self else { return }
                    switch result {
                    case .success(let value):
                        UIBlockingProgressHUD.dismiss()
                        let image = value.image
                        self.image = image
                    case .failure(let error):
                        print(error)
                        self.showAlert()
                    }
                }
        }
    }
}

extension SingleImageViewController {
    private func showAlert() {
        let alertController = UIAlertController(
            title: nil,
            message: "Что-то пошло не так. Попробовать еще раз?",
            preferredStyle: .alert)
        let tryAgain = UIAlertAction(title: "Повторить", style: .default, handler: { _ in
            self.downloadImage()
        })
        let cancelAction = UIAlertAction(title: "Не надо", style: .cancel, handler: { _ in self.dismiss(animated: false)
        })
        
        alertController.addAction(tryAgain)
        alertController.addAction(cancelAction)
        present(alertController, animated: true)
    }
}
