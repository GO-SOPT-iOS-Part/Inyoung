//
//  CreateAccountVC.swift
//  SOPT_TVING
//
//  Created by 김인영 on 2023/04/21.
//

import UIKit

class CreateAccountVC: UIViewController {
    
    private let setUsernameLabel = UILabel().then {
        $0.text = "닉네임을 입력해주세요"
        $0.font = .Font(.medium, size: 23)
        $0.textColor = .tvingBlack
    }
    
    private let usernameTextField = UITextField().then {
        $0.textColor = .tvingBlack
        $0.attributedPlaceholder = NSAttributedString(string: "닉네임?",
                                                      attributes: [NSAttributedString.Key.foregroundColor: UIColor.tvingBlack])
        $0.setLeftPaddingPoints(15)
        $0.backgroundColor = .tvingGray1
    }
    
    private lazy var saveButton = UIButton().then {
        $0.setTitle("저장하기", for: .normal)
        $0.setTitleColor(UIColor.tvingWhite, for: .normal)
        $0.backgroundColor = .tvingRed
        $0.addTarget(self, action: #selector(saveButtonDidTap), for: .touchUpInside)
    }
    
    // MARK: - life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setLayout()
    }
    
    // MARK: - functions
    
    @objc
    private func saveButtonDidTap() {
        self.dismiss(animated: true)
    }
    
}
extension CreateAccountVC {
    
    private func setUI() {
        view.backgroundColor = .tvingWhite
    }
    
    
    private func setLayout() {
        
        view.addSubviews(setUsernameLabel, usernameTextField, saveButton)
        
        setUsernameLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(40)
            $0.centerX.equalToSuperview()
        }
        
        usernameTextField.snp.makeConstraints {
            $0.top.equalTo(setUsernameLabel.snp.bottom).offset(30)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(52)
        }

        saveButton.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(10)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(52)
        }
        
    }
}
