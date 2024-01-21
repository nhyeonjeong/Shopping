//
//  UIImageView+Extension.swift
//  SeSAC Shopping
//
//  Created by 남현정 on 2024/01/20.
//

import UIKit

extension UIImageView {
    /// 프로필 디자인 구성
    func setProfileBoarder(selected: Bool) {
        DispatchQueue.main.async { // dispatch안해주면 이상하게 나옴
            self.layer.cornerRadius = self.frame.width / 2
            
            if selected {
                self.layer.borderWidth = 6
                self.layer.borderColor = CustomColor.pointColor?.cgColor
            }
            self.contentMode = .scaleAspectFill
        }
    }
}
