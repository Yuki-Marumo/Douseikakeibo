//
//  CustomViewController.swift
//

import UIKit

class CustomViewController: UIViewController, UITextFieldDelegate {
    
    var _activeTextField: UITextField? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        let allDeleteButton = UIBarButtonItem(title: "全件削除", style: .plain, target: self, action: #selector(deleteAll))
        allDeleteButton.tintColor = .systemRed
        self.navigationItem.rightBarButtonItem = allDeleteButton
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Notificationを設定する
        let nc = NotificationCenter.default
        nc.addObserver(self, selector: #selector(self.keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        nc.addObserver(self, selector: #selector(self.keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        hideKeyboardWhenTappedAround()
    }
    
    @objc func deleteAll() {
        alert(title: "全件削除", message: "全件削除します。よろしいですか？", okAction: okAction(_:), cancelAction: nil)
    }
    
    private func okAction(_ action: UIAlertAction) {
        RealmHelper.sharedInstance.deleteAll()
        NotificationCenter.default.post(name: .reload, object: nil)
    }
    
    @objc func hideKeyboard() {
        view.endEditing(true)
    }
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    // NotificationCenterからのキーボード表示通知に伴う処理
    @objc func keyboardWillShow(_ notification: Notification) {
        let rect = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue
        guard let keyboardHeight = rect?.size.height else {
            return
        }
        let duration: TimeInterval? = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double
        UIView.animate(withDuration: duration!, animations: { () in
            self.view.transform = CGAffineTransform(translationX: 0, y: -keyboardHeight)
        })
    }
    
    /** NotificationCenterからのキーボード非表示通知に伴う処理 */
    @objc func keyboardWillHide(_ notification: Notification) {
        let duration: TimeInterval? = notification.userInfo?[UIResponder.keyboardAnimationCurveUserInfoKey] as? Double
        UIView.animate(withDuration: duration!, animations: { () in
            self.view.transform = CGAffineTransform.identity
        })
    }

    /** 編集対象のTextFieldを保存する */
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        _activeTextField = textField
        return true;
    }

    /** Returnキーを押したときにキーボードを下げる */
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

}
