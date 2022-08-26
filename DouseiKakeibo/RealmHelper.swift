//
//  RealmHelper.swift
//  DouseiKakeibo
//
//  Created by 丸茂優輝 on 2020/12/03.
//

import Foundation
import RealmSwift

open class RealmHelper {
    // Singleton
    fileprivate static var sharedInstance_: RealmHelper! = nil
    
    static var sharedInstance: RealmHelper {
        get {
            if (sharedInstance_ == nil) {
                sharedInstance_ = RealmHelper()
                return sharedInstance_
            }
            return sharedInstance_
        }
    }
    public static func recreateSharedInstance() {
        sharedInstance_ = nil
    }
    
    func getItems(_ type: Int) -> Results<Item> {
        let realm = try! Realm()
        let data = realm.objects(Item.self).filter("type == " + String(type))
        return data
    }
    
    func getItem(_ id: Int) -> Item {
        let realm = try! Realm()
        let data = realm.objects(Item.self).filter("id == " + String(id)).first
        return data!
    }
    
    func getTotalAmount(_ type: Int) -> Int {
        let data = getItems(type)
        var totalAmount:Int = 0
        for record: Item in data {
            let taxIn: Int
            let amount: Int = record.amount
            if record.tax == 0 {
                taxIn = (amount * 108)/100
            } else {
                taxIn = (amount * 110)/100
            }
            totalAmount += taxIn
        }
        return totalAmount
    }
    
    // データを保存するための処理
    func add(product: String, amount: Int, tax: Int, type: Int) {
        
        let item = Item()
        let id = UserDefaultsHelper.sharedInstance.getID
        item.id = id
        item.amount = amount
        item.product = product
        item.tax = tax
        item.type = type
        do {
            let realm = try! Realm()
            try realm.write {
                realm.add(item)
            }
        } catch {}
        UserDefaultsHelper.sharedInstance.setID(id: id+1)
    }
    
    // データを更新するための処理
    func update(id: Int, product: String, amount: Int, tax: Int) {
        do {
            let realm = try! Realm()
            let data = realm.objects(Item.self).filter("id == " + String(id)).first!
            try realm.write {
                data.product = product
                data.amount = amount
                data.tax = tax
            }
        } catch {}
    }
    
    // データを削除するための処理
    func delete(id: Int) {
        do {
            let realm = try! Realm()
            let data = realm.objects(Item.self).filter("id == " + String(id)).first!
            try realm.write {
                realm.delete(data)
            }
        } catch {}
    }
    
    func deleteAll() {
        do {
            let realm = try! Realm()
            let data = realm.objects(Item.self)
            try realm.write {
                realm.delete(data)
            }
        } catch {}
    }
}
