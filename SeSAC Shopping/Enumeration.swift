//
//  Enumeration.swift
//  SeSAC Shopping
//
//  Created by 남현정 on 2024/01/20.
//

import UIKit

/// 색을 enum으로 관리
enum CustomColor {
//    case PointColor
//    case TextColor
    static let pointColor = UIColor(named: "PointColor")
    static let textColor = UIColor(named: "TextColor")
}

enum ImageStyle {
//    static let search = UIImage(systemName: "magnifyingglass")
    static let goBack = UIImage(systemName: "chevron.backward")
    static let notLike = UIImage(systemName: "heart")
    static let like = UIImage(systemName: "heart.fill")
    
    
}

enum Group: String, CaseIterable {
    case sim = " 정확도 "
    case date = " 날짜순 "
    case dsc = " 가격높은순 "
    case asc = " 가격낮은순 "
    
    func getNameString() -> String {
        return String(describing: self)
    }
}
