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
        
        self.profileImageView.setProfileBoarder(selected: self.isSelectedImage)
        
    }
}
