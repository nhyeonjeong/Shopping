//
//  ProfileCollectionViewCell.swift
//  SeSAC Shopping
//
//  Created by 남현정 on 2024/01/20.
//

import UIKit

class ProfileCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var profileImageView: UIImageView!
    var isSelectedImage: Bool = false
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configureView()
    }
    
    func configureCell(imageName: String) {
        profileImageView.image = UIImage(named: imageName)
    }

}

extension ProfileCollectionViewCell {
    func configureView() {
        DispatchQueue.main.async { // dispatch안해주면 이상하게 나옴(UI그리는 거는 main에서 해줘야함)
            self.layer.cornerRadius = self.frame.width / 2
        }
        profileImageView.contentMode = .scaleAspectFill
        profileImageView.setProfileBoarder(selected: isSelectedImage)
        
    }
}
