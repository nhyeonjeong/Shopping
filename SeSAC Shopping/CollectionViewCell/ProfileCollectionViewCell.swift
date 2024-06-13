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
    }
    
    func configureCell(imageName: String) {
        profileImageView.image = UIImage(named: imageName)
        profileImageView.contentMode = .scaleAspectFill
        profileImageView.setProfileBoarder(selected: isSelectedImage)
    }

}

