//
//  WelcomeVC.swift
//  SOPT_TVING
//
//  Created by 김인영 on 2023/04/21.
//

import UIKit

import SnapKit
import Then

final class WelcomeVC: UIViewController {
    
    // MARK: - UI Components
    
    private let logoImage = UIImageView(image: ImageLiterals.Logo.logoImage)
    
    private let completeLabel = UILabel().then {
        $0.text = "이름은 모르지만\n반가워요"
        $0.numberOfLines = 2
        $0.textAlignment = .center
        $0.textColor = .tvingWhite
        $0.font = UIFont.Font(.bold, size: 23)
    }
    
    private lazy var completeButton = UIButton().then {
        $0.setTitle("메인으로", for: .normal)
        $0.setTitleColor(UIColor.tvingWhite, for: .normal)
        $0.backgroundColor = .tvingRed
        $0.addTarget(self, action: #selector(mainButtonDidTap), for: .touchUpInside)
    }
    
    // MARK: - life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLayout()
    }
    
    // MARK: - functions
    
    func dataBind(_ name: String) {
        completeLabel.text = "\(name)님\n반가워요"
    }
    
    // MARK: - objc functions
    
    @objc
    private func mainButtonDidTap() {
        self.switchRootViewController(rootViewController: TabBarViewController(), animated: true, completion: nil)
    }
    
}
extension WelcomeVC {
    
    private func setLayout() {
        view.addSubviews(logoImage, completeLabel, completeButton)
        
        logoImage.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(210)
        }

        completeLabel.snp.makeConstraints {
            $0.top.equalTo(logoImage.snp.bottom).offset(50)
            $0.centerX.equalToSuperview()
        }

        completeButton.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(10)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(52)
        }
    }
}
