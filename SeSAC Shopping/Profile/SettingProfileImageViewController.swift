//
//  SettingProfileImageViewController.swift
//  SeSAC Shopping
//
//  Created by 남현정 on 2024/01/20.
//

import UIKit

class SettingProfileImageViewController: UIViewController {

    @IBOutlet weak var profileImageView: UIImageView!
    
    @IBOutlet weak var profileCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setBackBarButton()
        configureView()
    }
    
    func configureView() {
        navigationItem.title = "프로필 설정"
        
        setRandomImage()
        
        
    }
    
    func setRandomImage() {

        let randomImage = UIImage(named: "profile\(Int.random(in: 1...14))")
        profileImageView.setProfileBoarder(randomImage)
        
    }


}
