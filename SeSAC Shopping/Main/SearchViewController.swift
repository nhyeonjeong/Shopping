//
//  SearchViewController.swift
//  SeSAC Shopping
//
//  Created by 남현정 on 2024/01/20.
//

import UIKit

class SearchViewController: UIViewController {

    @IBOutlet weak var inputSearchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    var userName: String? = UserDefaultManager.shared.ud.string(forKey: "UserNickname")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        userName = UserDefaultManager.shared.ud.string(forKey: "UserNickname")
        navigationItem.title = "떠나고 싶은 \(userName ?? "이름없음")님의 새싹쇼핑"
    }
    
    
}

extension SearchViewController {
    func configureView() {
        navigationItem.title = "떠나고 싶은 \(userName ?? "이름없음")님의 새싹쇼핑"
        
        inputSearchBar.delegate = self
        
        inputSearchBar.placeholder = "브랜드, 상품, 프로필, 태그 등"
//        tableView.delegate = self
//        tableView.dataSource = self
        
//        searchbar.placeholder = "브랜드, 상품, 프로필, 태그 등"
        
        
    }
    
}

// 서치바 return눌렀을 때 함수
extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        // 화면전환
        let vc = storyboard?.instantiateViewController(withIdentifier: SearchResultViewController.identifier) as! SearchResultViewController
 
        vc.searchText = searchBar.text!
//        vc.callRequest(text: searchBar.text!, sort: Group.sim)
        
        navigationController?.pushViewController(vc, animated: true)
    }
}

//extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
//    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        
//        // 유저디폴트 분기문
//        <#code#>
//    }
//    
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        // 유저디폴트 분기문
//
//        <#code#>
//    }
//    
//}
