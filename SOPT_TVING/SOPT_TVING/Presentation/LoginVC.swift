//
//  ViewController.swift
//  SOPT_TVING
//
//  Created by 김인영 on 2023/04/14.
//

import UIKit

import SnapKit
import Then

final class LoginVC: UIViewController {
    
    // MARK: - UI Components
    
    private lazy var backButton = UIButton().then {
        $0.setImage(ImageLiterals.Icn.back, for: .normal)
        $0.addTarget(self, action: #selector(backButtonDidTap), for: .touchUpInside)
    }
    
    private let loginLabel = UILabel().then {
        $0.text = "TVING ID 로그인"
        $0.font = .Font(.bold, size: 23)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setLayout()
        
    }
    
    @objc
    private func backButtonDidTap() {
        print("back")
    }
}

// MARK: - Layout

extension LoginVC {
    
    private func setUI() {
        view.backgroundColor = .tvingWhite
    }
    
    private func setLayout() {
        view.addSubviews(backButton, loginLabel)
        
        loginLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
}

