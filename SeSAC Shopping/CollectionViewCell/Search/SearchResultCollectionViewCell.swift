//
//  SearchResultCollectionViewCell.swift
//  SeSAC Shopping
//
//  Created by 남현정 on 2024/01/21.
//

import UIKit

class SearchResultCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var resultImageView: UIImageView!
    
    @IBOutlet weak var mallNameLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    @IBOutlet weak var likeButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configureView()
    }
    
    func configureCell() {
        
    }

}

extension SearchResultCollectionViewCell {
    func configureView() {
        
        resultImageView.contentMode = .scaleAspectFill
        resultImageView.layer.cornerRadius = 15
        
        likeButton.layer.cornerRadius = likeButton.frame.width / 2
        
        likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
        likeButton.tintColor = .black
        likeButton.backgroundColor = .white
        
        mallNameLabel.font = .systemFont(ofSize: 13)
        mallNameLabel.textColor = CustomColor.textColor
        
        titleLabel.font = .systemFont(ofSize: 15)
        titleLabel.numberOfLines = 2
        titleLabel.textColor = CustomColor.textColor
        
        priceLabel.font = .boldSystemFont(ofSize: 16)
        priceLabel.textColor = CustomColor.textColor
    }
}
