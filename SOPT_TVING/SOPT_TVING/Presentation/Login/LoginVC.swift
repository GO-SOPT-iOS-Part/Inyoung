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
    
    private lazy var loginButton = UIButton().then {
        $0.setTitle("로그인하기", for: .normal)
        $0.setTitleColor(UIColor.tvingWhite, for: .normal)
        $0.backgroundColor = .tvingRed
        $0.addTarget(self, action: #selector(loginButtonDidTap), for: .touchUpInside)
    }
    
    private lazy var findIDButton = UIButton().then {
        $0.setTitle("아이디 찾기", for: .normal)
        $0.setTitleColor(UIColor.tvingGray2, for: .normal)
        $0.titleLabel?.font = .Font(.semiBold, size: 14)
    }
    
    private lazy var findPasswordButton = UIButton().then {
        $0.setTitle("비밀번호 찾기", for: .normal)
        $0.setTitleColor(UIColor.tvingGray2, for: .normal)
        $0.titleLabel?.font = .Font(.semiBold, size: 14)
    }
    
    private let makeAccountLabel = UILabel().then {
        $0.text = "아직 계정이 없으신가요?"
        $0.font = .Font(.semiBold, size: 14)
        $0.textColor = .tvingGray3
    }
    
    private lazy var makeAccountButton = UIButton().then {
        let attributedText = NSAttributedString(
            string: "닉네임 만들러가기",
            attributes: [
                .underlineStyle: NSUnderlineStyle.single.rawValue,
                .underlineColor: UIColor.tvingGray2,
                .font: UIFont.Font(.semiBold, size: 14),
                .foregroundColor: UIColor.tvingGray2
            ])
        $0.setAttributedTitle(attributedText, for: .normal)
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
    
    @objc
    private func loginButtonDidTap() {
        print(00)
    }
}

// MARK: - Layout

extension LoginVC {
    
    private func setUI() {
        view.backgroundColor = .tvingBlack
    }
    
    private func setLayout() {
        view.addSubviews(backButton,
                         loginLabel,
                         emailTextField,
                         passwordTextField,
                         loginButton,
                         findIDButton,
                         findPasswordButton,
                         makeAccountLabel,
                         makeAccountButton
        )
        
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
            $0.top.equalTo(emailTextField.snp.bottom).offset(11)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        
        loginButton.snp.makeConstraints {
            $0.top.equalTo(passwordTextField.snp.bottom).offset(21)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(52)
        }
        
        findIDButton.snp.makeConstraints {
            $0.top.equalTo(loginButton.snp.bottom).offset(41)
            $0.leading.equalToSuperview().inset(95)
        }
        
        findPasswordButton.snp.makeConstraints {
            $0.top.equalTo(findIDButton)
            $0.trailing.equalToSuperview().inset(95)
        }
        
        makeAccountLabel.snp.makeConstraints {
            $0.top.equalTo(findIDButton.snp.bottom).offset(28)
            $0.leading.equalToSuperview().offset(51)
        }
        
        makeAccountButton.snp.makeConstraints {
            $0.top.equalTo(findPasswordButton.snp.bottom).offset(28)
            $0.trailing.equalToSuperview().inset(60)
            $0.height.equalTo(makeAccountLabel.snp.height)
            $0.width.equalTo(127)
        }
    }
    
}

