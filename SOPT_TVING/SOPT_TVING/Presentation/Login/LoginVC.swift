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
        $0.font = .Font(.medium, size: 23)
        $0.textColor = .tvingWhite
    }
    
    private lazy var emailTextField = CustomTextField(type: .email)
    private lazy var passwordTextField = CustomTextField(type: .password)
    
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
        view.backgroundColor = .tvingBlack
    }
    
    private func setLayout() {
        view.addSubviews(backButton, loginLabel, emailTextField, passwordTextField)
        
        backButton.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            $0.leading.equalToSuperview().offset(24)
            $0.size.equalTo(15)
        }
        
        loginLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(50)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(37)
        }
        
        emailTextField.snp.makeConstraints {
            $0.top.equalTo(loginLabel.snp.bottom).offset(41)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        
        passwordTextField.snp.makeConstraints {
            $0.top.equalTo(emailTextField.snp.bottom).offset(7)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
    }
    
}

