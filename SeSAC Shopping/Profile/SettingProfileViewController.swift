//
//  SettingProfieViewController.swift
//  SeSAC Shopping
//
//  Created by 남현정 on 2024/01/20.
//

import UIKit
import TextFieldEffects

class SettingProfileViewController: UIViewController {
    
    enum CheckNickname: String {
        case notFitLen = "2글자 이상 10글자 미만으로 설정해주세요"
        case containSpecificChar = "닉네임에 @,#,$,% 는 포함할 수 없어요"
        case containNum = "닉네임에 숫자는 포함할 수 없어요"
        
        static let specificChar = ["@","#","$","%"] // 포함하면 안되는 문자들
        
    }

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var cameraImageView: UIImageView!
    
    @IBOutlet weak var nicknameTextField: TextFieldEffects!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var finishProfileButton: UIButton!
    
    // 유저디폴트에 저장된게 없다면 랜덤으로 보여지도록 하기(디폴트)
    var imageName = "profile\(Int.random(in: 1...14))"
    // 유저디폴트에 저장된게 없다면 아무것도 안쓰여있음
    var nickName = ""
    
//    var statusText: String {
//        didSet {
//            viewDidLoad()
//        }
//    }
    
    /// 완료버튼을 누를 수 있는지
    var isAbleButton = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        profileImageView.isUserInteractionEnabled = true // imageView클릭 가능하도록

        setBackBarButton()
        configureView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // Temp 유저디폴트에 임시저장된 이미지가 있다면 유저디폴트에 있는걸로 보여주기
        // 없으면 랜덤으로 보여줌
        if let imagename = UserDefaultManager.shared.ud.string(forKey: "TempProfileImage") {
            imageName = imagename
            profileImageView.image = UIImage(named: imageName)
        }
        
        // 유저디폴트에 저장된 이름이 있으면 가져와서 보여주기
        // 없으면 그냥
        if let nickname = UserDefaultManager.shared.ud.string(forKey: "UserNickname") {
            nickName = nickname
            nicknameTextField.text = nickName
        }
    }
    // 글자가 입력될때마다 실시간 감지
    @IBAction func editNicknameTextField(_ sender: HoshiTextField) {
        // 글자수 조건에 맞지 않을 때
        print(#function)
        let text = sender.text!
        
        isAbleButton = false // 입력했으면 false로 초기화
        
        if !checkLen(text: text) {
            statusLabel.text = CheckNickname.notFitLen.rawValue
        } else if !checkChar(text: text) { // 특수문자 조건에 안맞으면
            
            statusLabel.text = CheckNickname.containSpecificChar.rawValue
            
        } else if !checkNum(text: text) {
            statusLabel.text = CheckNickname.containNum.rawValue
        } else { // 모든 조건을 만족할 때
            print("correct")
            statusLabel.text = "사용할 수 있는 닉네임이에요"
            isAbleButton = true
        }
        statusLabel.reloadInputViews() // 안배웠는데 써봤다...(있는줄몰랐움)
    }
    
    // 완료버튼
    @IBAction func finishButtonClicked(_ sender: UIButton) {
        // isAbleButton이 true일때만 화면전환가능하도록 , UserDefault저장
        if isAbleButton {
            // 유저디폴트 저장
            UserDefaultManager.shared.ud.set(nicknameTextField.text!, forKey: "UserNickname")
            // 프로필이미지 진짜 유저디폴트에 저장
            UserDefaultManager.shared.ud.set(imageName, forKey: "UserProfileImage")
            
            let sb = UIStoryboard(name: "Search", bundle: nil)
            let vc = sb.instantiateViewController(withIdentifier: "WindowRootViewController") as! UITabBarController

            vc.modalPresentationStyle = .fullScreen // 뒤로 갈 일이 없다.
            present(vc, animated: true)
            
        }
    }
    // 프로필 이미지 클릭했을 때 화면 전환
    @IBAction func profileImageClicked(_ sender: UITapGestureRecognizer) {

        let vc = storyboard?.instantiateViewController(withIdentifier: SettingProfileImageViewController.identifier) as! SettingProfileImageViewController
        
        vc.selectedImageString = imageName
        
        navigationController?.pushViewController(vc, animated: true)

    }
    /// false : 길이가 맞지 않는 경우
    func checkLen(text: String) -> Bool {
        return text.count < 2 || text.count >= 10 ? false : true
    }
    /// false : 포함하면 안되는 문자 포함할 경우
    func checkChar(text: String) -> Bool {
        return text.contains("@") || text.contains("#") || text.contains("$") || text.contains("%") ? false : true

    }
    /// false : 숫자 포함할 경우
    func checkNum(text: String) -> Bool {
        for t in text {
            if t.isNumber { return false }
        }
        
        return true
    }
 
}

extension SettingProfileViewController {
    func configureView() {
        navigationItem.title = "프로필 설정"
        // 이미지
        setRandomImage()
        cameraImageView.image = UIImage(named: "camera")
        
//        if let nickname = UserDefaultManager.shared.ud.string(forKey: "UserNickname") {
//            nickName = nickname
//        }
        // textfieldeffects
        nicknameTextField.text = nickName
        nicknameTextField.placeholder = " 닉네임을 입력해주세요 :)"
        
//        statusLabel.text = ""
        statusLabel.textColor = CustomColor.pointColor
        statusLabel.font = .systemFont(ofSize: 13)
        
        
        // 버튼
        finishProfileButton.configureButton(title: "완료")
        
    }
    
    func setRandomImage() {

        profileImageView.image = UIImage(named: imageName)
        profileImageView.setProfileBoarder(selected: true)
        
    }
}
