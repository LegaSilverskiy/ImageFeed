//
//  WebViewPresenter.swift
//  ImageFeed
//
//  Created by Олег Серебрянский on 3/1/24.
//

import Foundation



final class WebViewPresenter: WebViewPresenterProtocol {
    
    //MARK: Public properties
    weak var view: WebViewViewControllerProtocol?
    var authHelper: AuthHelperProtocol
        
        init(authHelper: AuthHelperProtocol) {
            self.authHelper = authHelper
        }
    
    //MARK: Public methods
    func viewDidLoad() {
        guard let request = authHelper.authRequest() else { return }
               
               view?.load(request: request)
               didUpdateProgressValue(0)
    }
    
    func didUpdateProgressValue(_ newValue: Double) {
        let newProgressValue = Float(newValue)
        view?.setProgressValue(newProgressValue)
        
        let shouldHideProgress = shouldHideProgress(for: newProgressValue)
        view?.setProgressHidden(shouldHideProgress)
    }
    
    func shouldHideProgress(for value: Float) -> Bool {
        abs(value - 1.0) <= 0.0001
    }
    
    func code(from url: URL) -> String? {
            authHelper.code(from: url)
        }
}
