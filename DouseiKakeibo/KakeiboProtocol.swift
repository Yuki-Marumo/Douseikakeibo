//
//  KakeiboProtocol.swift
//  DouseiKakeibo
//
//  Created by 丸茂優輝 on 2022/08/22.
//

import UIKit
import RealmSwift

protocol KakeiboProtocol: UIViewController {
    
    var productField: UITextField! { get }
    var amountField: UITextField! { get }
    var taxSegment: UISegmentedControl! { get }
    var tableView: UITableView! { get }
    var displayId: Int? { get set }
    var items: Results<Item>! { get set }
    var amountA: UILabel! { get }
    var amountB: UILabel! { get }
    
    func setAmounts()
    
}

extension KakeiboProtocol {
    func tapRegistButton(_ type: Int) {
        let amount: Int
        let product: String
        if let _amount = amountField.text {
            if _amount == "" {
                alert(title: "金額エラー", message: "金額を入力してください。", action: nil, viewController: self)
                return
            }
            if _amount.isAlphanumeric() {
                amount = Int(_amount)!
            } else {
                alert(title: "金額エラー", message: "金額には半角数字を入力してください。", action: nil, viewController: self)
                return
            }
        } else {
            amount = 0
        }
        if let _product = productField.text {
            product = _product
        } else {
            product = ""
        }
        let tax = taxSegment.selectedSegmentIndex

        if let _displayId = displayId {
            // 更新
            RealmHelper.sharedInstance.update(id: _displayId, product: product, amount: amount, tax: tax)
        } else {
            // 新規登録
            RealmHelper.sharedInstance.add(product: product, amount: amount, tax: tax, type: type)
        }
        clearItem()
        loadItems(type)
    }
    
    func tapDeleteButton(_ type: Int) {
        if let _displayId = displayId {
            RealmHelper.sharedInstance.delete(id: _displayId)
        }
        clearItem()
        loadItems(type)
    }
    
    func clearItem() {
        productField.text = ""
        amountField.text = ""
        taxSegment.selectedSegmentIndex = 0
        amountA.text = ""
        amountB.text = ""
        displayId = nil
    }
    
    func loadItems(_ type: Int) {
        items = RealmHelper.sharedInstance.getItems(type)
        tableView.reloadData()
        setAmounts()
    }
    
    func tableRow(index: Int) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "Cell")
        let item = items[index]
        let amount = String(item.amount)
        let tax: String
        if item.tax == 0 {
            tax = "8"
        } else {
            tax = "10"
        }
        cell.textLabel?.text = item.product + "　¥" + amount + "　" + tax + "%"
        return cell
    }
    
    func didSelect(index: Int) {
        let item = items[index]
        productField.text = item.product
        amountField.text = String(item.amount)
        displayId = item.id
        if item.tax == 0 {
            taxSegment.selectedSegmentIndex = 0
        } else {
            taxSegment.selectedSegmentIndex = 1
        }
    }
}
