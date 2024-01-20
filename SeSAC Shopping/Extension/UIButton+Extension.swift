//
//  UIButton+Extension.swift
//  SeSAC Shopping
//
//  Created by 남현정 on 2024/01/20.
//

import UIKit

extension UIButton {
    /// 두 번 쓰이는 버튼 구성 extension으로
    func configureButton(title: String) {
        self.setTitle(title, for: .normal)
        self.backgroundColor = CustomColor.pointColor
        self.layer.cornerRadius = 10
        self.setTitleColor(CustomColor.textColor, for: .normal)
        self.titleLabel?.font = .boldSystemFont(ofSize: 17)
    }
}
