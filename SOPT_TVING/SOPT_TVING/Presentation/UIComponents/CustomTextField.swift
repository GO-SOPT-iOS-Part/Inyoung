//
//  CustomTextField.swift
//  SOPT_TVING
//
//  Created by 김인영 on 2023/04/15.
//

import UIKit

import SnapKit
import Then

enum CustomTextFieldType : CaseIterable {
    case email
    case password
}

class CustomTextField: UIView, UITextFieldDelegate {
    
    var isSecured: Bool = true {
        didSet {
            if isSecured {
                securedLayout()
            } else {
                unsecuredLayout()
            }
        }
    }
    
    // MARK: - UI Components
    
    private lazy var textField = UITextField().then {
        $0.backgroundColor = .tvingGray4
    }
    
    private lazy var removeAllButton: UIButton = {
        let button = UIButton()
        button.setImage(ImageLiterals.Icn.close, for: .normal)
        button.addTarget(self, action: #selector(removeAllButtonDidTap), for: .touchUpInside)
        return button
    }()
    
    private lazy var secureButton: UIButton = {
        let button = UIButton()
        button.setImage(ImageLiterals.Icn.eyeClose, for: .normal)
        button.addTarget(self, action: #selector(secureButtonDidTap), for: .touchUpInside)
        return button
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 16
        stackView.backgroundColor = .tvingGray4
        return stackView
    }()
    
    // MARK: - Life Cycle
    
    init(type: CustomTextFieldType) {
        super.init(frame: .zero)
        setLayout(type: type)
        setUI(type: type)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc
    private func removeAllButtonDidTap() {
        textField.text?.removeAll()
    }
    
    @objc
    private func secureButtonDidTap() {
        textField.isSecureTextEntry.toggle()
        self.isSecured = textField.isSecureTextEntry
    }
    
    private func securedLayout() {
        secureButton.setImage(ImageLiterals.Icn.eyeClose, for: .normal)
    }
    
    private func unsecuredLayout() {
        secureButton.setImage(ImageLiterals.Icn.eyeOpen, for: .normal)
    }
}

extension CustomTextField {
    
    private func setUI(type: CustomTextFieldType) {
        switch type {
        case .email:
            textField.attributedPlaceholder = NSAttributedString(string: "아이디",
                                                                 attributes: [NSAttributedString.Key.foregroundColor: UIColor.tvingGray2])
            textField.isSecureTextEntry = false
        case .password:
            textField.attributedPlaceholder = NSAttributedString(string: "비밀번호",
                                                                 attributes: [NSAttributedString.Key.foregroundColor: UIColor.tvingGray2])
            textField.isSecureTextEntry = true
        }
        
        self.textField.setLeftPaddingPoints(15)
    }
    
    private func setLayout(type: CustomTextFieldType) {
        
        self.addSubviews(textField, stackView)
        
        switch type {
        case .email:
            stackView.addArrangedSubview(removeAllButton)
        case .password:
            stackView.addArrangedSubview(secureButton)
            stackView.addArrangedSubview(removeAllButton)
        }
        
        self.snp.makeConstraints {
            $0.height.equalTo(52)
        }
        
        textField.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        stackView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.height.equalTo(20)
            $0.trailing.equalToSuperview().inset(14)
            $0.width.equalTo(type == .password ? 56 : 20)
        }
        
        removeAllButton.snp.makeConstraints {
            $0.width.height.equalTo(20)
        }

        secureButton.snp.makeConstraints {
            $0.width.height.equalTo(20)
        }
    }
}
