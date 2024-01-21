//
//  SettingTableViewCell.swift
//  SeSAC Shopping
//
//  Created by 남현정 on 2024/01/20.
//

import UIKit

class SettingTableViewCell: UITableViewCell {

    @IBOutlet weak var settingLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configureView()
    }
    
    func configureCell(text: String) {
        settingLabel.text = text
    }

}


extension SettingTableViewCell {
    func configureView() {
        settingLabel.textColor = CustomColor.textColor
        settingLabel.font = .systemFont(ofSize: 13)
    }
}
