//
//  UIViewController+Extension.swift
//  SeSAC Shopping
//
//  Created by 남현정 on 2024/01/20.
//

import UIKit

// 강제성 부여
// 재사용 가능할때 채택
protocol ReusableProtocol {
    static var identifier: String {get}
    
}

extension UIViewController {
    /// navigationbarbutton에서 뒤로가기 dismiss
    func setBackBarButton() {
        let button = UIBarButtonItem(image: ImageStyle.goBack, style: .plain, target: self, action: #selector(popView))
        button.tintColor = CustomColor.textColor
        self.navigationItem.leftBarButtonItem = button
    }
    
    @objc func popView() {
        print(#function)
        self.navigationController?.popViewController(animated: true)
    }
}

// extension안에 많은 기능을 분리
extension UIViewController: ReusableProtocol {
    // ViewController의 identifier도 여기서 묶고 싶을 때
    static var identifier: String {
        return String(describing: self) // 스트링인터폴레이션(문자열보간법)사용하면 옵셔널이 풀릴 수도 있다-->??
    }
}


