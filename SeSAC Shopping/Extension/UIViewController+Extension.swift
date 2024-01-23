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


extension UIViewController {
    /// 좋아요한 상품인지 확인
    func checkLikedProduct(productid: String) -> UIImage {
        
        let likeList = UserDefaultManager.shared.ud.array(forKey: "LikeProducts")
        if let likeList {
            if likeList.contains(where: { id in
                id as! String == productid
            }) {
                return ImageStyle.like!
            } else {
                return ImageStyle.notLike!
            }
            
        } else { // 좋아요 정보가 없어도 빈 하트
            return ImageStyle.notLike!
        }
    }
    
}

extension UIViewController {
    // 알람띄우기(UIViewController+Extension)
    func showAlert(title: String, message: String, buttonTitle: String, completionHandelr: @escaping () -> Void) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        // 버튼 클릭하면 실행하는 코드
        let action = UIAlertAction(title: buttonTitle, style: .default) { _ in
            
            completionHandelr()
        }
        
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        
        alert.addAction(action)
        alert.addAction(cancel)
        
        present(alert, animated: true)
    }
}
