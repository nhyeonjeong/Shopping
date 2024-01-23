//
//  AppDelegate.swift
//  SeSAC Shopping
//
//  Created by 남현정 on 2024/01/20.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        //appearance 뷰컨트롤러에 사용하지 않더라도 색 바꾸기 가능
        // 모든 뷰의 레이블 글자색을 블루로?(디폴트를 바꿔주는것/ 지정된 색이 있으면 그 색으로 됨)
//        UIView.appearance().backgroundColor = UIColor(red: 0, green: 0, blue: 146, alpha: 1)
        UILabel.appearance().textColor = UIColor(red: 255, green: 255, blue: 255, alpha: 1)
        
        
        // notification 허용할건지?
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { success, error in
            print(success, error)
        }
        
        // 매일 한 번씩 보내줄 노티 만들기 - appdelegate에서 만들어야 실행될 것 같아서 그렇게 만듦,.
        everydayNotification()
        
        return true
    }
    
    /// Nofification
    func everydayNotification() {
        
        let content = UNMutableNotificationContent()
        content.title = "새싹 쇼핑에서 알립니다"
        content.body = "하루에 한 번씩 쇼핑리스트를 관리해보세요!"
        content.badge = 1
        
        var component = DateComponents()
        
        component.hour = 12
        component.minute = 00
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: component, repeats: true)
        
        let request = UNNotificationRequest(identifier: "everydayNoti", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request)
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

