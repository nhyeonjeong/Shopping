# ShoppingApp 리드미

## 🛍️스크린샷



## 🛍️프로젝트 소개
> 상품을 검색하고 북마크할 수 있으며 해당 상품의 웹사이트로 연결해주는 앱
- iOS 1인 개발
- 개발 기간
    - 기간 : 24.1.20 ~ 24.1.25
- 개발 환경
    - 최소버전 15.0
    - 세로모드, 라이트모드만 지원
 `
## 🛍️핵심기능
- 상품이름 검색
- 정확도 / 날짜순 / 가격 높은, 낮은 순 카테고리 지원
- 상품 북마크 기능
- 상품 웹사이트 연결
- 매일 정오 알람기능

## 🛍️사용한 기술스택
- UIKit, StoryBoard, MVP
- Alamofire, Kingfisher, TextFieldEffects, WebKit
- GCD, Singleton, completionHandler, UserDefault
- UICollectionView, UICollectionViewDataSourcePrefetching, UITableView
- UNUserNotificationCenter

## 🛍️기술설명
- MVP패턴
  - 왜 이기술을 사용하게 되었고, 어떤 부분을 구현했는지? 얼마나 잘 설계했는지의 느낌?
- 회원, 북마크 등 사용하는 부분이 많아 UserDefulat를 관리하는 class Singleton패턴으로 구성
- UserDefault에 사용자의 닉네임, 북마크한 상품의 id 저장
- 네트워크 요청 모델을 구조화하기 위해 NetworkManager 구성 및 completionHandler 활용
    - 통신 성공시 completionHandler으로 결과 반환
- Offset-Based Pagenation 로 상품 조회 
- UserNotification은 AppDelegate에서 알람허용확인 및 등록
- Extension/Protocol 를 통해 효율적으로 메서드 구성
  
## 🛍️트러블슈팅
### `1. CollectionviewCell의 재사용 문제 해결 `

1-1) 문제

프로필을 선택했을 때 선택된 cell만 border을 주고 싶었는데 재사용되는 UICollectionViewCell때문에 선택할때마다 여러 셀에 무작위로 border처리가 들어가는 문제. 

1-2) 해결

프로필이미지의 border가 여러 화면에서 쓰이고 있어 이미지의 UI를 구성하는 setProfileBoarder함수를 UIImageView의 extension으로 분리.
이 함수에서는 선택유무를 매개변수로 받도록 함.
이미지가 클릭되어 collectionview를 다시 그릴 때마다 cell class에서 가진 isSelectedImage변수에 따라서 테투리가 적용되도록 수정.

<details>
<summary>변경 후 코드</summary>
<div markdown="1">
<img width="521" alt="스크린샷 2024-06-12 오후 4 20 04" src="https://github.com/nhyeonjeong/Shopping/assets/102401977/8e7f5444-7cd6-4603-8a7e-7809ef24e459">
<img width="911" alt="스크린샷 2024-06-12 오후 4 22 32" src="https://github.com/nhyeonjeong/Shopping/assets/102401977/d64eafef-72f3-4352-9949-ea6d66cd30c2">

</div>
</details>

### `2. GCD를 이용해 CollectionViewCell의 cornerRadius 적용`

2-1) 문제

프로필이미지가 나열된 collectionview에서 cell의 radius를 차지한 이미지크기의 절반으로 주고 싶었지만 예상과 다르게 원모양으로 cell이 그려지지 않음.
이미지의 정확한 frame.width가 정해지기 전에 먼저 radius를 적용하기 때문에 원하는 모양이 나오지 않았던 것.

2-2) 해결

radius를 적용하는 코드의 시점은 약간 늦춰주기 위해 GCD 사용. 
UI는 메인스레드에서 그려야 하고, Queue에 해당 작업을 보내고 이후에 처리하도록 DispathQueue.main.async적용

<details>
<summary>변경 후 코드</summary>
<div markdown="1">

<img width="391" alt="스크린샷 2024-06-13 오전 12 12 37" src="https://github.com/nhyeonjeong/Shopping/assets/102401977/14b6a349-bacd-4b83-af10-1f5edbc23165">

</div>
</details>


## 🛍️기술회고
extension으로 연관성있는 코드끼리 분리하여 코드를 작성한 것은 좋았지만, ViewController에 UI와 관련된 코드를 다 넣다 보니까 코드도 길어지고 가독성이 떨어졌던 것 같음.
데이터끼리 가공되고 연산되는 과정은 또 다른 파일로 분리해서 사용하는 것이 이후 유지보수에 좋을 것 같아서 다음에는 코드를 분리해서 사용하려고 함.
UI는 스토리보드로 짜니까 한 눈에 화면구성을 알 수 있어서 좋았지만, constraints를 조정할 때 화면이 복잡해지면 한계가 있는 것을 느껴 코드베이스로 작업해보려고 함.
