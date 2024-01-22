//
//  WebViewController.swift
//  SeSAC Shopping
//
//  Created by 남현정 on 2024/01/22.
//

import UIKit
import WebKit

class WebViewController: UIViewController {

    @IBOutlet weak var webView: WKWebView!
    var navigationTitle = ""
    var urlString = ""
    var productId = ""
    
    var likeSystemImage = ImageStyle.notLike
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
    }
    
    @objc func likeBarButtonItemClicked() {
        // 좋아하지 않는 상태였다면 ? 유저디폴트 추가
        if likeSystemImage == ImageStyle.notLike {
            likeSystemImage = ImageStyle.like
            
            var likelist = UserDefaultManager.shared.ud.array(forKey: "LikeProducts")
            if var list = likelist {
                list.append(productId) // append(_ newElement: Element) 해야 오류 안나는 이유?
                likelist = list
            } else {
                likelist = [productId]
            }
            
            UserDefaultManager.shared.ud.set(likelist, forKey: "LikeProducts")
            
        } else { // 좋아하는상태였으면 유저디폴트에서 빼기
            likeSystemImage = ImageStyle.notLike
            
            var likelist = UserDefaultManager.shared.ud.array(forKey: "LikeProducts")
            likelist?.removeAll(where: { id in
                id as! String == productId
            })
            
            UserDefaultManager.shared.ud.set(likelist, forKey: "LikeProducts")
        }
        // 좋아요 버튼 누르면 뷰 다시 그리기
        viewDidLoad()
    }
}

extension WebViewController {
    
    func configureView() {
        navigationItem.title = navigationTitle
        // 뒤로가기 버튼
        setBackBarButton()
        
        // 좋아요 버튼
        setBarButton()
    
        // 웹사이트 띄우기
        if let url = URL(string: urlString) {
            
            let request = URLRequest(url: url)
            webView.load(request) // load : 특정 url을 로딩해준다.
        }
        
    }
    
    func setBarButton() {
        // 하트 버튼 그려지는 곳
        let likeButton = UIBarButtonItem(image: likeSystemImage, style: .plain, target: self, action: #selector(likeBarButtonItemClicked))
        
        navigationItem.rightBarButtonItem = likeButton
    }
    
}
