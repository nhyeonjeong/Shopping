//
//  RecentSearchTableViewCell.swift
//  SeSAC Shopping
//
//  Created by 남현정 on 2024/01/20.
//

import UIKit

class RecentSearchTableViewCell: UITableViewCell {

    @IBOutlet weak var magnifyingglassImage: UIImageView!
    @IBOutlet weak var recentLabel: UILabel!
    @IBOutlet weak var xButton: UIButton!
    
    var tableView: UITableView = UITableView()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureView()
    }


    func configureCell(text: Any, tableview: UITableView) {
        recentLabel.text = text as? String
        tableView = tableview
        
    }
    
    // x버튼을 누르면 유저디폴트에서 삭제되도록
    @objc func deleteRecentSearch() {
        print(#function)
        var recentSearchList = UserDefaultManager.shared.ud.array(forKey: "RecentSearch")!
        
        recentSearchList.removeAll (where: {text in
            text as! String == recentLabel.text!
        })
        // 유저디폴트에 다시 저장
        UserDefaultManager.shared.ud.set(recentSearchList, forKey: "RecentSearch")
        
        tableView.reloadData() // 넘겨받은 tableview 다시 로드
        
    }
}

extension RecentSearchTableViewCell {
    func configureView() {
        magnifyingglassImage.image = UIImage(systemName: "magnifyingglass")
        magnifyingglassImage.tintColor = CustomColor.textColor
        
        recentLabel.font = .systemFont(ofSize: 13)
        recentLabel.textColor = CustomColor.textColor
        
        xButton.setImage(UIImage(systemName: "xmark"), for: .normal)
        xButton.tintColor = CustomColor.textColor
        
        xButton.addTarget(self, action: #selector(deleteRecentSearch), for: .touchUpInside)
    }
}
