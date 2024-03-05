//
//  ImagesListCell.swift
//  ImageFeed
//
//  Created by Олег Серебрянский on 12/8/23.
//

import UIKit
import Kingfisher

protocol ImageListCellDelegate: AnyObject {
    func imageListCellDidTapLike(_ cell: ImagesListCell)
}
public final class ImagesListCell: UITableViewCell {
    
    //MARK: Public Properties
    static let reuseIdentifier = "ImagesListCell"
    weak var delegate: ImageListCellDelegate?
    
    //MARK: IB Outlets
    @IBOutlet weak var cellImage: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    
    //MARK: Override methods
    public override func prepareForReuse() {
        super.prepareForReuse()
        cellImage.kf.cancelDownloadTask()
    }
    
    //MARK: IB Actions
    
    @IBAction func likeButtonClicked() {
        delegate?.imageListCellDidTapLike(self)
    }
}
