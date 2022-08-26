//
//  String+Extension.swift
//  DouseiKakeibo
//
//  Created by 丸茂優輝 on 2020/12/05.
//

import Foundation

extension String {
    // 半角数字の判定
    func isAlphanumeric() -> Bool {
        return self.range(of: "[^0-9]+", options: .regularExpression) == nil && self != ""
    }
}
