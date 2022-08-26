//
//  ShopItem.swift
//  DouseiKakeibo
//
//  Created by 丸茂優輝 on 2020/12/03.
//

import Foundation
import RealmSwift

class Item: Object  {
    @objc dynamic var id = 0
    
    @objc dynamic var product: String = ""
    @objc dynamic var amount: Int = 0
    // 0=8％ 1=10％
    @objc dynamic var tax: Int = 0
    // 0=割り勘 1=彼氏 2=彼女
    @objc dynamic var type: Int = 0
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
