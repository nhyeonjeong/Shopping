//
//  SearchAPIManager.swift
//  SeSAC Shopping
//
//  Created by 남현정 on 2024/01/22.
//

import UIKit
import Alamofire

struct SearchAPIManager {
    // 보여줄 컨텐츠
    static var resultList: Search = Search(total: 0, start: 0, display: 0, items: [Item(title: "", link: "", image: "", lprice: "", mallName: "", productId: "")])
    
    func callRequest(text: String, sort: Group, page: Int, completionHandler: @escaping (Search) -> Void) {
        let query = text.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        
        let url = "https://openapi.naver.com/v1/search/shop.json?query=\(query)&display=30&sort=\(sort.getNameString())&start=\((page-1) * 30 + 1)"
        
        let headers: HTTPHeaders = ["X-Naver-Client-Id": APIKey.clientID,
                                    "X-Naver-Client-Secret": APIKey.clientSecret]
        
        AF.request(url, method: .get, headers: headers).responseDecodable(of: Search.self) { response in
            switch response.result {
            case .success(let success):
                if page == 1 {
                    SearchAPIManager.resultList = success
                    
                } else {
                    SearchAPIManager.resultList.items.append(contentsOf: success.items)
                }
                completionHandler(SearchAPIManager.resultList)
                           
            case .failure(let failure):
                print(failure)
            }
       
        }
    }
    
}
