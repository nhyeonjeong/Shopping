//
//  SearchResultCollectionViewCell.swift
//  SeSAC Shopping
//
//  Created by 남현정 on 2024/01/21.
//

import UIKit
import Kingfisher

class SearchResultCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var resultImageView: UIImageView!
    
    @IBOutlet weak var mallNameLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    @IBOutlet weak var likeButton: UIButton!
    
    var likeImage = ImageStyle.notLike
    var productId = ""
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configureView()
        
    }
    
    func configureCell(item: Item) {

        if let url = URL(string: item.image) {
            resultImageView.kf.setImage(with: url) // 링크기반으로 이미지 가져온다.
        }
        
        mallNameLabel.text = item.mallName
        titleLabel.text = item.title
        priceLabel.text = "₩\(item.lprice)"
        productId = item.productId
        
        // productId 지정한 뒤 좋아요버튼 그리기
        configureLikeButton()
    }
    
    func configureLikeButton() {
        // 좋아요 버튼
        let likeImage = UIViewController().checkLikedProduct(productid: productId)
        likeButton.setImage(likeImage, for: .normal)
        
        // 좋아요 버튼이 눌리면
        likeButton.addTarget(self, action: #selector(likeBarButtonItemClicked), for: .touchUpInside)
    }
    
    @objc func likeBarButtonItemClicked() {
        // 좋아하지 않는 상태였다면 ? 유저디폴트 추가
        if likeImage == ImageStyle.notLike {
            likeImage = ImageStyle.like
            
            var likelist = UserDefaultManager.shared.ud.array(forKey: "LikeProducts")
            if var list = likelist {
                list.append(productId) // append(_ newElement: Element) 해야 오류 안나는 이유?
                likelist = list
            } else {
                likelist = [productId]
            }
            
            UserDefaultManager.shared.ud.set(likelist, forKey: "LikeProducts")
            
        } else { // 좋아하는상태였으면 유저디폴트에서 빼기
            likeImage = ImageStyle.notLike
            
            var likelist = UserDefaultManager.shared.ud.array(forKey: "LikeProducts")
            likelist?.removeAll(where: { id in
                id as! String == productId
            })
            
            UserDefaultManager.shared.ud.set(likelist, forKey: "LikeProducts")
        }
        
        // 좋아요 버튼 누르면 좋아요 버튼만 다시 그리기
        configureLikeButton()
    }

}

extension SearchResultCollectionViewCell {
    func configureView() {
        
        resultImageView.contentMode = .scaleAspectFill
        resultImageView.layer.cornerRadius = 15
        
        likeButton.layer.cornerRadius = likeButton.frame.width / 2
        likeButton.tintColor = .point
        likeButton.backgroundColor = .white
        
        mallNameLabel.font = .systemFont(ofSize: 13)
        mallNameLabel.textColor = CustomColor.textColor
        
        titleLabel.font = .systemFont(ofSize: 14)
        titleLabel.numberOfLines = 2
        titleLabel.textColor = CustomColor.textColor
        
        priceLabel.font = .boldSystemFont(ofSize: 16)
        priceLabel.textColor = CustomColor.textColor
        

    }
}
