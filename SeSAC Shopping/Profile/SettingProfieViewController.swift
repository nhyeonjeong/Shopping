//
//  SettingProfieViewController.swift
//  SeSAC Shopping
//
//  Created by 남현정 on 2024/01/20.
//

import UIKit
import TextFieldEffects

class SettingProfieViewController: UIViewController {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var cameraImageView: UIImageView!
    
    @IBOutlet weak var nicknameTextField: TextFieldEffects!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var finishProfileButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        profileImageView.isUserInteractionEnabled = true // imageView클릭 가능하도록

        setBackBarButton()
        configureView()
    }
    
    @IBAction func profileImageClicked(_ sender: UITapGestureRecognizer) {

        let vc = storyboard?.instantiateViewController(withIdentifier: SettingProfileImageViewController.identifier) as! SettingProfileImageViewController
  
        navigationController?.pushViewController(vc, animated: true)

    }
 
}

extension SettingProfieViewController {
    func configureView() {
        navigationItem.title = "프로필 설정"
        // 이미지
        setRandomImage()
        cameraImageView.image = UIImage(named: "camera")
        
        // textfieldeffects
        nicknameTextField.placeholder = " 닉네임을 입력해주세요 :)"
        
        statusLabel.text = "닉네임에 @는 포함할 수 없어요."
        statusLabel.textColor = CustomColor.pointColor
        statusLabel.font = .systemFont(ofSize: 13)
        
        
        // 버튼
        finishProfileButton.configureButton(title: "완료")
        
    }
    
    func setRandomImage() {

        let randomImage = UIImage(named: "profile\(Int.random(in: 1...14))")
        profileImageView.image = randomImage
        profileImageView.setProfileBoarder()
        
    }
}
