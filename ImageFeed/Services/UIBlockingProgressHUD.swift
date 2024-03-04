//
//  UIBlockingProgressHUD.swift
//  ImageFeed
//
//  Created by Олег Серебрянский on 2/12/24.
//

import UIKit
import ProgressHUD

final class UIBlockingProgressHUD {
    private static var window: UIWindow? {
        return UIApplication.shared.windows.first
    }
    static func show() {
        window?.isUserInteractionEnabled = false
        ProgressHUD.animate()
    }
    static func dismiss() {
        window?.isUserInteractionEnabled = true
        ProgressHUD.dismiss()
    }
    static func like() {
        window?.isUserInteractionEnabled = false
        ProgressHUD.progress("We're liking", 1.0)
    }
    
    static func dislike() {
        window?.isUserInteractionEnabled = false
        ProgressHUD.progress("We're disliking", 1.0)
    }
}

public enum ProgressStatus {
    case show
    case dismiss
    case like
    case dislike
}
