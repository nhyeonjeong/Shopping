//
//  SettingProfileTableViewCell.swift
//  SeSAC Shopping
//
//  Created by 남현정 on 2024/01/20.
//

import UIKit

class SettingProfileTableViewCell: UITableViewCell {

    @IBOutlet weak var backgroundUIView: UIView!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var likeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configureView()
        
    }
    
    func configureCell(image: String, nickname: String, likeCount: Int) {
        profileImageView.image = UIImage(named: image)
        print("configureCell")
        nameLabel.text = "떠나고 싶은 \(nickname)"

        likeLabel.text = "\(likeCount)개의 상품을 좋아하고 있어요!" // 색이 과연 다르게 나올지...
    }

}


extension SettingProfileTableViewCell {
    func configureView() {
        backgroundUIView.backgroundColor = .clear
        profileImageView.setProfileBoarder(selected: true)
        
        nameLabel.textColor = CustomColor.textColor
        nameLabel.font = .boldSystemFont(ofSize: 17)
        
        likeLabel.textColor = CustomColor.textColor
        likeLabel.font = .boldSystemFont(ofSize: 15)
        
    }
}
