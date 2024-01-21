//
//  SettingProfileImageViewController.swift
//  SeSAC Shopping
//
//  Created by 남현정 on 2024/01/20.
//

import UIKit

class SettingProfileImageViewController: UIViewController {
    
    enum ProfileImage: Int, CaseIterable {
        case profile1 = 1
        case profile2, profile3, profile4, profile5, profile6, profile7
        case profile8, profile9, profile10, profile11, profile12, profile13, profile14
        
        func getImageName() -> String {
            print(self.rawValue)
            return "profile\(self.rawValue)"
        }
    }
    
    // 이전화면에서 받아온 이미지이자 선택했을 때 갱신되는 이미지
    var selectedImageString = ""
    
    @IBOutlet weak var profileImageView: UIImageView!
    
    @IBOutlet weak var profileCollectionView: UICollectionView!
    
    let inset: CGFloat = 15 // inset
    let spacing: CGFloat = 15 // 셀 사이 간격
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setBackBarButton() // 백버튼
        configureView()
        configureCollectionView()
        
        profileCollectionView.collectionViewLayout = settingLayout()
    }
    
}

extension SettingProfileImageViewController {
    
    func settingLayout() -> UICollectionViewFlowLayout {
        
        let layout = UICollectionViewFlowLayout()
    
        let cellWidth = UIScreen.main.bounds.width - (inset * 2) - (spacing * 3)
        layout.itemSize = CGSize(width: cellWidth/4, height: cellWidth/4)//셀 크기 CGSize - 넚이, 높이 의미
        layout.sectionInset = UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset) // sectioninset은 셀을 어디서 시작할지 전체 상하좌우 간격 설정
        // 셀 사이 간격은 비율로 맞추는게 좋긴 하다
        layout.minimumLineSpacing = spacing // 셀과 셀 사이 제일 짧은 세로 간격
        layout.minimumInteritemSpacing = spacing // 셀과 셀 사이 제일 짧은 가로 간격
        layout.scrollDirection = .vertical // default는 vertical(순서는 제일 왼쪽부터 세로로도 다 채우고 그 다음으로 쌓임
        
        return layout
    }
    
    func configureView() {
        navigationItem.title = "프로필 설정"
        
        setImageView() // 이미지 설정
        
    }
    
    func setImageView() {

        profileImageView.image = UIImage(named: selectedImageString)
        profileImageView.setProfileBoarder(selected: true)
        
    }
}

extension SettingProfileImageViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func configureCollectionView() {
        
        profileCollectionView.delegate = self
        profileCollectionView.dataSource = self
        
        let xib = UINib(nibName: ProfileCollectionViewCell.identifier, bundle: nil)
        profileCollectionView.register(xib, forCellWithReuseIdentifier: ProfileCollectionViewCell.identifier)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ProfileImage.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProfileCollectionViewCell.identifier, for: indexPath) as! ProfileCollectionViewCell
        
        // 이미지이름 자체 가져오기
        let profileName = ProfileImage.allCases[indexPath.row].getImageName()
        
        cell.configureCell(imageName: profileName)
        
//        print("cellfor: \(self.selectedImageString)")

        // 선택됐다면 테두리 효과
        if ProfileImage.allCases[indexPath.row].getImageName() == self.selectedImageString {
            cell.isSelectedImage = true
            cell.configureView()
            
        } else {
            cell.isSelectedImage = false
            cell.configureView()
        }
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // 갱신
        self.selectedImageString = ProfileImage.allCases[indexPath.row].getImageName()
//        print("selected: \(self.selectedImageString)")
        self.viewDidLoad()// 상단 프로필 이미지 바꾸기
    
        self.profileCollectionView.reloadData()
        
        // 임시저장하는 유저디폴트 저장
        UserDefaultManager.shared.ud.set(selectedImageString, forKey: "TempProfileImage")
        
    }
    
    
}
