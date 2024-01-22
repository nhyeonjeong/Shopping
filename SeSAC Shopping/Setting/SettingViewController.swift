//
//  SettingViewController.swift
//  SeSAC Shopping
//
//  Created by 남현정 on 2024/01/20.
//

import UIKit

class SettingViewController: UIViewController {
    // Setting에 들어갈 문구들
    enum Setting: CaseIterable {
        case profile
        case setting
        
        var data: [String] {
            switch self {
            case .setting :
                return ["공지사항", "자주 묻는 질문", "1:1문의", "알림 설정", "처음부터 시작하기"]
            case .profile :
                return []
            }
        }
    }

    @IBOutlet weak var settingTableView: UITableView!
    
    var nickname: String? = ""
    var profileImage: String? = ""
    var like: [Any]? = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print(#function)
        nickname = UserDefaultManager.shared.ud.string(forKey: "UserNickname")
        profileImage = UserDefaultManager.shared.ud.string(forKey: "UserProfileImage")
        like = UserDefaultManager.shared.ud.array(forKey: "LikeProducts")
        
        settingTableView.reloadRows(at: [IndexPath(row: 0, section: 0)], with: .none)
    }
    
    /// 처음부터 다시 시작하는 함수(이전 리소스 삭제)
    func reset() {
        UserDefaultManager.shared.ud.removeObject(forKey: "UserNickname")
        UserDefaultManager.shared.ud.removeObject(forKey: "UserProfileImage")
        UserDefaultManager.shared.ud.removeObject(forKey: "LikeProducts")
    
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        
        let sceneDelegate = windowScene?.delegate as? SceneDelegate
        
        
        let sb = UIStoryboard(name: "Onboarding", bundle: nil)
    
        let vc = sb.instantiateViewController(withIdentifier: "OnboardingNavigationController") as! UINavigationController

        vc.modalPresentationStyle = .fullScreen// 기본이 .automatic
        vc.modalTransitionStyle = .coverVertical

        sceneDelegate?.window?.rootViewController = vc
        sceneDelegate?.window?.makeKeyAndVisible()

    }
    
}

extension SettingViewController {
    func configureView() {
        navigationItem.title = "설정"
        
        settingTableView.delegate = self
        settingTableView.dataSource = self

        
        let xib = UINib(nibName: SettingProfileTableViewCell.identifier, bundle: nil)
        settingTableView.register(xib, forCellReuseIdentifier: SettingProfileTableViewCell.identifier)
        
        let xib2 = UINib(nibName: SettingTableViewCell.identifier, bundle: nil)
        settingTableView.register(xib2, forCellReuseIdentifier: SettingTableViewCell.identifier)
        
    }
}

extension SettingViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return Setting.allCases.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 1 : Setting.setting.data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = settingTableView.dequeueReusableCell(withIdentifier: SettingProfileTableViewCell.identifier, for: indexPath) as! SettingProfileTableViewCell
//            print(nickname, profileImage)
            
            if let image = profileImage, let nickname {
                cell.configureCell(image: image, nickname: nickname, likeCount: like?.count ?? 0)
            }
            
            return cell
        } else {
            let cell = settingTableView.dequeueReusableCell(withIdentifier: SettingTableViewCell.identifier, for: indexPath) as! SettingTableViewCell
            
        
            
            cell.configureCell(text: Setting.setting.data[indexPath.row])
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 100
        } else {
            return 44
        }
    }
    
    // 셀 선택됐을 때
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(#function)
        
        if indexPath.section == 0 {
            // 프로필이미지 임시저장하는 데이터와 실제데이터 동기화
            UserDefaultManager.shared.ud.set(profileImage, forKey: "TempProfileImage")
            let sb = UIStoryboard(name: "Profile", bundle: nil)
   
            let vc = sb.instantiateViewController(withIdentifier: SettingProfileViewController.identifier) as! SettingProfileViewController
            
            navigationController?.pushViewController(vc, animated: true)
            
        } else {
            if indexPath.row == 4 { // 처음부터 시작하기면 alert
                // 1. 알럿 컨텐츠title: 굵은 제목, message: 그 밑의 문구
                let alert = UIAlertController(title: "처음부터 시작하기", message: "데이터를 모두 초기화하시겠습니까?", preferredStyle: .alert)
                
                // 2. 버튼 생성
                let cancelButton = UIAlertAction(title: "취소", style: .cancel)
       
                let okButton = UIAlertAction(title: "확인", style: .default) { _ in self.reset()}
                
                alert.addAction(cancelButton)
                alert.addAction(okButton)

                present(alert, animated: true)
            }
        }
    }
    
}
