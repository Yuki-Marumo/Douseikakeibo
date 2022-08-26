//
//  UserDefaultsHelper.swift
//  DouseiKakeibo
//
//  Created by 丸茂優輝 on 2020/12/04.
//

import Foundation

open class UserDefaultsHelper {
    
    // Singleton
    fileprivate static var sharedInstance_: UserDefaultsHelper! = nil
    
    static var sharedInstance: UserDefaultsHelper {
        get {
            if (sharedInstance_ == nil) {
                sharedInstance_ = UserDefaultsHelper()
                return sharedInstance_
            }
            return sharedInstance_
        }
    }
    public static func recreateSharedInstance() {
        sharedInstance_ = nil
    }
    
    var getID: Int {
        return UserDefaults.standard.integer(forKey: "id")
    }
    
    func setID(id: Int) {
        UserDefaults.standard.set(id, forKey: "id")
    }
}
