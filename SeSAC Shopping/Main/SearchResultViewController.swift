//
//  SearchResultViewController.swift
//  SeSAC Shopping
//
//  Created by 남현정 on 2024/01/20.
//

import UIKit

class SearchResultViewController: UIViewController {
    /// 결과 분류하는 버튼
    enum Group: String, CaseIterable {
        case accuracy = "정확도"
        case Bydate = "날짜순"
        case highestPrice = "가격높은순"
        case lowestPrice = "가격낮은순"
        
    }
    
    let buttonName = Group.allCases
    
    @IBOutlet weak var resultCount: UILabel!
    
    @IBOutlet var classifyButtons: [UIButton]!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        
    }
    

}


extension SearchResultViewController {
    
    func configureView() {
        for i in 0..<buttonName.count {
            classifyButtons[i].setTitle(buttonName[i].rawValue, for: .normal)
            classifyButtons[i].setTitleColor(CustomColor.textColor, for: .normal)
            classifyButtons[i].layer.cornerRadius = 10
            classifyButtons[i].layer.borderWidth = 1
            classifyButtons[i].layer.borderColor = CustomColor.textColor?.cgColor
        }
        
        setBackBarButton()
    }
    
}
