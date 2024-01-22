//
//  SearchViewController.swift
//  SeSAC Shopping
//
//  Created by 남현정 on 2024/01/20.
//

import UIKit

class SearchViewController: UIViewController {

    @IBOutlet weak var inputSearchBar: UISearchBar!
    
    @IBOutlet weak var emptyImageView: UIImageView!
    @IBOutlet weak var emptyLabel: UILabel!

    @IBOutlet weak var topUIView: UIView!
    @IBOutlet weak var currentSearchLabel: UILabel!
    @IBOutlet weak var removeAllButton: UIButton!
    @IBOutlet weak var recentSearchTableView: UITableView!
    
    let manager = SearchAPIManager()
    
    var recentSearchList: [Any] = []
    
    var userName: String? = UserDefaultManager.shared.ud.string(forKey: "UserNickname")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        configureTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        userName = UserDefaultManager.shared.ud.string(forKey: "UserNickname")
        navigationItem.title = "떠나고 싶은 \(userName ?? "이름없음")님의 새싹쇼핑"
        
        hideTableView()
    }
    
    @IBAction func removeAllButtonClicked(_ sender: UIButton) {
        UserDefaultManager.shared.ud.set([], forKey: "RecentSearch")
        recentSearchTableView.reloadData()
    }
    /// 최근검색어가 없으면 tableview숨기기 / 아니면 나오도록
    func hideTableView() {
        // 최근 검색어 가져오기
        let currentSearchList = UserDefaultManager.shared.ud.array(forKey: "RecentSearch")
        
        if let current = currentSearchList {
            if current.count == 0 { // 비어있어도 숨기기
                topUIView.isHidden = true
                recentSearchTableView.isHidden = true
            } else {
                self.recentSearchList = current
                topUIView.isHidden = false
                recentSearchTableView.isHidden = false
            }
            
        } else { // 최근 검색어가 없다면 uiview와 tableview 숨기기
            topUIView.isHidden = true
            recentSearchTableView.isHidden = true
        }
    }
    
    
}

extension SearchViewController {
    func configureView() {

        inputSearchBar.placeholder = "브랜드, 상품, 프로필, 태그 등"
        
        configureEmptyView() // 최근 검색어가 없을 때 보여지는 뷰
        
        currentSearchLabel.text = "최근 검색"
        currentSearchLabel.textColor = CustomColor.textColor
        currentSearchLabel.font = .boldSystemFont(ofSize: 13)
        removeAllButton.setTitle("모두 지우기", for: .normal)
        removeAllButton.setTitleColor(CustomColor.pointColor, for: .normal)
        
        inputSearchBar.delegate = self
        recentSearchTableView.delegate = self
        recentSearchTableView.dataSource = self
  
    }
    
    func configureEmptyView() {
        emptyImageView.image = UIImage(named: "empty")
        emptyImageView.contentMode = .scaleAspectFill
        
        emptyLabel.text = "최근 검색어가 없어요"
        emptyLabel.textColor = CustomColor.textColor
        emptyLabel.textAlignment = .center
    }
    
}

extension SearchViewController: UISearchBarDelegate {
    // 서치바 return눌렀을 때 함수
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        // 화면전환
        let vc = storyboard?.instantiateViewController(withIdentifier: SearchResultViewController.identifier) as! SearchResultViewController
 
        vc.searchText = searchBar.text!
//        vc.callRequest(text: searchBar.text!, sort: Group.sim)
        
        navigationController?.pushViewController(vc, animated: true)
        
        // 유저디폴트에 저장
        let list = UserDefaultManager.shared.ud.array(forKey: "RecentSearch")
        var recentList: [Any] = []
        if let list {
            recentList = list
            // 유저디폴트에 저장되지 않은 단어만 넣기
            if !recentList.contains(where: { word in
                word as! String == searchBar.text!
            }) {
                recentList.append(searchBar.text!)
            }
        }
        
        UserDefaultManager.shared.ud.set(recentList, forKey: "RecentSearch")
        
        recentSearchTableView.reloadData()
    }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {

    func configureTableView() {
        recentSearchTableView.delegate = self
        recentSearchTableView.dataSource = self
        
        let xib = UINib(nibName: RecentSearchTableViewCell.identifier, bundle: nil)
        recentSearchTableView.register(xib, forCellReuseIdentifier: RecentSearchTableViewCell.identifier)
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        hideTableView() // 유저디폴트확인
        return recentSearchList.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 유저디폴트 분기문
        let cell = recentSearchTableView.dequeueReusableCell(withIdentifier: RecentSearchTableViewCell.identifier, for: indexPath) as! RecentSearchTableViewCell
        
        cell.configureCell(text: recentSearchList[indexPath.row], tableview: recentSearchTableView )
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 화면전환
        let vc = storyboard?.instantiateViewController(withIdentifier: SearchResultViewController.identifier) as! SearchResultViewController
 
        vc.searchText = recentSearchList[indexPath.row] as! String
        
        navigationController?.pushViewController(vc, animated: true)
    }
}
