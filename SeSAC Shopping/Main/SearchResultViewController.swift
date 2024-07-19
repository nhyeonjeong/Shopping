//
//  SearchResultViewController.swift
//  SeSAC Shopping
//
//  Created by 남현정 on 2024/01/20.
//

import UIKit
import Alamofire

class SearchResultViewController: UIViewController {
    
    @IBOutlet weak var buttonStackView: UIStackView!
    @IBOutlet weak var resultCount: UILabel!
    @IBOutlet var sortButtons: [UIButton]!
    @IBOutlet weak var resultCollectionview: UICollectionView!
    
    let buttonName = Group.allCases
    
    let manager = SearchAPIManager()
    
    var selectedSort = Group.sim // 선택된 버튼
    
    var searchText = "" // 검색단어 넘어와서 네트워크 통신
    
    var page = 1
    var isEnd = false // 마지막 페이지인지
    
    // 보여줄 컨텐츠
    var resultList: Search = Search(total: 0, start: 0, display: 0, items: [Item(title: "", link: "", image: "", lprice: "", mallName: "", productId: "")]) {
        didSet {
            resultCollectionview.reloadData()
        }
    }
    
    let inset: CGFloat = 15
    let itemSpacing: CGFloat = 15 // 가로간격
    let lineSpacing: CGFloat = 20 // 세로간격
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        configureCollectionView()
        
        manager.callRequest(text: searchText, sort: Group.sim, page: page) { value in
            self.resultList = value
            self.resultCount.text = "\(self.resultList.total) 개의 검색 결과"
            // 통신 후에는 컬렉션뷰 다시 그리기
//            self.resultCollectionview.reloadData()
            
        } // 제일 처음에는 정확도로
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // 웹뷰에서 한 좋아요가 바로 반영되도록
        resultCollectionview.reloadData()
    }
    
    // sortButtons 눌렸을 때
    @IBAction func sortButtonClicked(_ sender: UIButton) {
        page = 1
        manager.callRequest(text: searchText, sort: Group.allCases[sender.tag], page: page) { value in
            
            self.resultList = value
            self.resultCount.text = "\(self.resultList.total) 개의 검색 결과"
            // 통신 후에는 컬렉션뷰 다시 그리기
//            self.resultCollectionview.reloadData()
        }
        
        resultCollectionview.scrollToItem(at: IndexPath(row: 0, section: 0), at: .top, animated: false)

        
        // 버튼 디자인도 바뀌도록
        selectedSort = Group.allCases[sender.tag]
        configureButtonColor()
        buttonStackView.reloadInputViews()
    }

}


extension SearchResultViewController {
    
    func configureView() {
        view.backgroundColor = UIColor(named: "background")
        resultCollectionview.backgroundColor = .clear
        
        navigationItem.title = searchText
        configureButtonColor()
        
        resultCount.textColor = CustomColor.pointColor
        
        setBackBarButton()
    }
    
    /// 상단 버튼 색
    func configureButtonColor() {
        for i in 0..<buttonName.count {
            // 선택된 버튼이라면
            if selectedSort == Group.allCases[i] {
                sortButtons[i].setTitleColor(.white, for: .normal)
                sortButtons[i].backgroundColor = CustomColor.pointColor // 검은색?
            } else {
                sortButtons[i].setTitleColor(CustomColor.pointColor, for: .normal)
                sortButtons[i].backgroundColor = .white

            }
            sortButtons[i].layer.borderColor = CustomColor.pointColor?.cgColor
            // 공통되는 부분
            sortButtons[i].tag = i // 버튼마다 tag달아주기
            sortButtons[i].setTitle(buttonName[i].rawValue, for: .normal)
            sortButtons[i].layer.cornerRadius = 8
            sortButtons[i].layer.borderWidth = 1
        }
    }
    
}

extension SearchResultViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func configureCollectionView() {
        resultCollectionview.delegate = self
        resultCollectionview.dataSource = self
        resultCollectionview.prefetchDataSource = self
        
        let xib = UINib(nibName: SearchResultCollectionViewCell.identifier, bundle: nil)
        resultCollectionview.register(xib, forCellWithReuseIdentifier: SearchResultCollectionViewCell.identifier)
        
        resultCollectionview.collectionViewLayout = settingLayout()
        
    }
    
    func settingLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        let width = UIScreen.main.bounds.width - (inset * 2) - itemSpacing
        
        let cellWidth = width / 2
        layout.itemSize = CGSize(width: cellWidth, height: cellWidth * 1.4)
        layout.sectionInset = UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset) // sectioninset은 셀을 어디서 시작할지 전체 상하좌우 간격 설정
        // 셀 사이 간격은 비율로 맞추는게 좋긴 하다
        layout.minimumLineSpacing = lineSpacing // 셀과 셀 사이 제일 짧은 세로 간격
        layout.minimumInteritemSpacing = itemSpacing // 셀과 셀 사이 제일 짧은 가로 간격
        layout.scrollDirection = .vertical
        return layout
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return resultList.items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        print(#function)
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchResultCollectionViewCell.identifier, for: indexPath) as! SearchResultCollectionViewCell
        
        cell.configureCell(item: resultList.items[indexPath.row])
 
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        let vc = storyboard?.instantiateViewController(withIdentifier: WebViewController.identifier) as! WebViewController
  
        let productId = resultList.items[indexPath.row].productId
        vc.navigationTitle = resultList.items[indexPath.row].title
        vc.urlString = "https://search.shopping.naver.com/product/\(productId)"
        vc.productId = productId
        
        // 좋아요한 상품인지 구별해서 다음화면으로 넘기기
        vc.likeSystemImage = checkLikedProduct(productid: productId) // enum에서 static으로 함수를 바꿔주니까 오류가 사라졌다.
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
}


extension SearchResultViewController: UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        
        for item in indexPaths {
            let display = resultList.display
            // 수학인가..
            // 마지막 Row에서 4정도 뒤에 셀에 있고, 마지막 페이지가 아닐떄 다시 로드
            if page * display - 4 == item.row && !isEnd {
                page += 1
                isEnd = resultList.total < page * display ? true : false
                manager.callRequest(text: searchText, sort: selectedSort, page: page) { value in
                    self.resultList = value
                    // 통신 후에는 컬렉션뷰 다시 그리기
                    self.resultCollectionview.reloadData()
                }

            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cancelPrefetchingForItemsAt indexPaths: [IndexPath]) {
        //
    }

}
