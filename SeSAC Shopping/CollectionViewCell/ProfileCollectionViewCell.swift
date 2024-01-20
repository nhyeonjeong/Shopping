//
//  ProfileCollectionViewCell.swift
//  SeSAC Shopping
//
//  Created by 남현정 on 2024/01/20.
//

import UIKit

class ProfileCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var profileImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configureCell()
    }

}

extension ProfileCollectionViewCell {
    func configureCell() {
        
        profileImageView.setProfileBoarder(/*<#T##image: UIImage?##UIImage?#>*/)
    }
}
