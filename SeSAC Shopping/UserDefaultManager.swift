//
//  UserDefaultManager.swift
//  SeSAC Shopping
//
//  Created by 남현정 on 2024/01/21.
//

import Foundation

// 싱글톤
class UserDefaultManager {
    private init() {}
    
    static let shared = UserDefaultManager()
    
    let ud = UserDefaults.standard

    
}
