//
//  UIImageView+Extension.swift
//  SeSAC Shopping
//
//  Created by 남현정 on 2024/01/20.
//

import UIKit

extension UIImageView {
    /// 프로필 디자인 구성
    func setProfileBoarder(_ image: UIImage?) {
        self.image = image
        self.layer.cornerRadius = self.frame.width/2
        self.layer.borderWidth = 6
        self.layer.borderColor = CustomColor.pointColor?.cgColor
        
        self.contentMode = .scaleAspectFill
    }
}
