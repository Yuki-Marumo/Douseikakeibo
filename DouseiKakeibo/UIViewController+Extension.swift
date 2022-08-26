//
//  UIViewController+Extension.swift
//  DouseiKakeibo
//
//  Created by 丸茂優輝 on 2022/08/22.
//

import UIKit

extension UIViewController {

    func alert(title:String, message:String, action: ((UIAlertAction) -> Void)?, viewController: UIViewController) {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK",
                                      style: .default,
                                      handler: action ))
        viewController.present(alert, animated: true)
    }
    
    func alert(title: String?, message: String?, okAction: ((UIAlertAction) -> Void)?, cancelAction : ((UIAlertAction) -> Void)?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK",
                                      style: .default,
                                      handler: okAction))
        alert.addAction(UIAlertAction(title: "キャンセル",
                                      style: .cancel,
                                      handler: cancelAction))
        DispatchQueue.main.async {
            self.present(alert, animated: true)
        }
    }
}
