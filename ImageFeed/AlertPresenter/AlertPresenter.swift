//
//  AlertPresenter.swift
//  ImageFeed
//
//  Created by Олег Серебрянский on 2/15/24.
//

import UIKit

protocol AlertPresenterDelegate: AnyObject {
    func showAlert()
}

final class AlertPresenter: UIAlertController {
    
    weak var delegate: AlertPresenterDelegate?
    
    func showAlert() {
        let alertController = UIAlertController(title: "Что-то пошло не так(", message: "Не удалось войти в систему", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Оr", style: .cancel)
        alertController.addAction(cancelAction)
        present(alertController, animated: true)
    }
}
