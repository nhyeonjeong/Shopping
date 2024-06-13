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
        
        DispatchQueue.main.async {
            self.layer.cornerRadius = self.frame.width / 2
        }
        self.contentMode = .scaleAspectFill
        
        if selected {
            self.layer.borderWidth = 6
            self.layer.borderColor = CustomColor.pointColor?.cgColor
        } else { // 여기서도 테두리를 업애줘야 한다.
            self.layer.borderWidth = .zero
        }
    }
}
