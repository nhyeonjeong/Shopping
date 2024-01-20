//
//  OnboardingViewController.swift
//  SeSAC Shopping
//
//  Created by 남현정 on 2024/01/20.
//

import UIKit

class OnboardingViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var startAppButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        settingView()
    }

    @IBAction func startButtonClicked(_ sender: UIButton) {

        let sb = UIStoryboard(name: "Profile", bundle: nil)

        let vc = sb.instantiateViewController(withIdentifier: SettingProfieViewController.identifier) as! SettingProfieViewController
        
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
}

extension OnboardingViewController {
    func settingView() {
        titleLabel.text = "SeSAC\nShopping"
        titleLabel.textColor = CustomColor.pointColor
        titleLabel.textAlignment = .center
        titleLabel.font = .boldSystemFont(ofSize: 40)
        titleLabel.numberOfLines = 2
        
        mainImageView.image = UIImage(named: "onboarding")
        mainImageView.contentMode = .scaleAspectFill
        
        startAppButton.configureButton(title: "시작하기")
        
    }
}
