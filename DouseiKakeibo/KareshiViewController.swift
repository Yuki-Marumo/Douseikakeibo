//
//  KareshiViewController.swift
//  DouseiKakeibo
//
//  Created by 丸茂優輝 on 2020/12/03.
//

import UIKit
import RealmSwift

class KareshiViewController: CustomViewController, KakeiboProtocol {
    
    var items: Results<Item>!
    var displayId: Int?
    var newerID: Int!
    
    @IBOutlet weak var productField: UITextField!
    @IBOutlet weak var amountField: UITextField!
    @IBOutlet weak var taxSegment: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var amountA: UILabel!
    @IBOutlet weak var amountB: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newerID = UserDefaults.standard.integer(forKey: "id")

        productField.delegate = self
        amountField.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        amountField.keyboardType = UIKeyboardType.decimalPad
        clearItem()
        loadItems(1)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(reload), name: .reload, object: nil)
    }
    
    @objc func reload() {
        clearItem()
        loadItems(1)
    }
    
    func setAmounts() {
        let totalAmount = RealmHelper.sharedInstance.getTotalAmount(1)
        let allAmount = RealmHelper.sharedInstance.getTotalAmount(0)/2 + totalAmount
        amountA.text = String(totalAmount)
        amountB.text = String(allAmount)
    }
    
    @IBAction func tapRegistButton(_ sender: Any) {
        tapRegistButton(1)
    }
    
    @IBAction func tapDeleteButton(_ sender: Any) {
        tapDeleteButton(1)
    }
}

extension KareshiViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        didSelect(index: indexPath.row)
    }
}

extension KareshiViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableRow(index: indexPath.row)
    }
}

