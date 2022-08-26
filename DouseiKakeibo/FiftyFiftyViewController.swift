//
//  FiftyFiftyViewController.swift
//  DouseiKakeibo
//
//  Created by 丸茂優輝 on 2020/12/03.
//

import UIKit
import RealmSwift

class FiftyFiftyViewController: CustomViewController, KakeiboProtocol {
    
    var items: Results<Item>!
    var displayId: Int?
    var newerID: Int!
    
    @IBOutlet weak var productField: UITextField!
    @IBOutlet weak var amountField: UITextField!
    @IBOutlet weak var taxSegment: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var amountA: UILabel!
    @IBOutlet weak var amountB: UILabel!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(reload), name: .reload, object: nil)
    }
    
    @objc func reload() {
        clearItem()
        loadItems(0)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newerID = UserDefaults.standard.integer(forKey: "id")

        productField.delegate = self
        amountField.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        amountField.keyboardType = UIKeyboardType.decimalPad
        clearItem()
        loadItems(0)
    }
    
    func setAmounts() {
        let totalAmount = RealmHelper.sharedInstance.getTotalAmount(0)
        let oneAmount = totalAmount/2
        amountA.text = String(totalAmount)
        amountB.text = String(oneAmount)
    }
    
    func tapAllDeleteButton(_ sender: Any) {
        RealmHelper.sharedInstance.deleteAll()
        NotificationCenter.default.post(name: .reload, object: nil)
    }
    
    @IBAction func tapRegistButton(_ sender: Any) {
        tapRegistButton(0)
        NotificationCenter.default.post(name: .reload, object: nil)
    }
    
    @IBAction func tapDeleteButton(_ sender: Any) {
        tapDeleteButton(0)
        NotificationCenter.default.post(name: .reload, object: nil)
    }
}

extension FiftyFiftyViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        didSelect(index: indexPath.row)
    }
}

extension FiftyFiftyViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableRow(index: indexPath.row)
    }
}
