//
//  UITableViewCell+Extension.swift
//  SeSAC Shopping
//
//  Created by 남현정 on 2024/01/20.
//

import UIKit

// extension안에 많은 기능을 분리
extension UITableViewCell: ReusableProtocol {
    // ViewController의 identifier도 여기서 묶고 싶을 때
    static var identifier: String {
        return String(describing: self) // 스트링인터폴레이션(문자열보간법)사용하면 옵셔널이 풀릴 수도 있다-->??
    }
}
