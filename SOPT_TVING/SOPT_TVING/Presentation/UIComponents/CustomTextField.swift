//
//  CustomTextField.swift
//  SOPT_TVING
//
//  Created by 김인영 on 2023/04/15.
//

import UIKit

import SnapKit
import Then

class CustomTextField: UIView {
    
    enum CustomTextFieldType : CaseIterable {
        case email
        case password
        
        var placeholder: String {
            switch self {
            case .email:
                return "아이디"
            case .password:
                return "비밀번호"
            }
        }
    }
    
    var isSecured: Bool = true {
        didSet {
            if isSecured {
                securedLayout()
            } else {
                unsecuredLayout()
            }
        }
    }
    
    let textFieldType: CustomTextFieldType
    
    // MARK: - UI Components
    
    private lazy var textField = UITextField().then {
        $0.backgroundColor = .tvingGray4
        $0.textColor = .tvingGray2
        $0.delegate = self
    }
    
    private let stackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 16
        $0.backgroundColor = .tvingGray4
        $0.isHidden = true
    }
    
    private lazy var removeAllButton = UIButton().then {
        $0.setImage(ImageLiterals.Icn.close, for: .normal)
        $0.addTarget(self, action: #selector(removeAllButtonDidTap), for: .touchUpInside)
    }
    
    private lazy var secureButton = UIButton().then {
        $0.setImage(ImageLiterals.Icn.eyeClose, for: .normal)
        $0.addTarget(self, action: #selector(secureButtonDidTap), for: .touchUpInside)
    }
    
    // MARK: - Life Cycle
    
    init(type: CustomTextFieldType) {
        self.textFieldType = type
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
    
    func getText() -> String {
        if let text = textField.text {
            return text
        }
        return ""
    }
}

extension CustomTextField {
    
    private func setUI(type: CustomTextFieldType) {
        switch type {
        case .email:
            textField.isSecureTextEntry = false
        case .password:
            textField.isSecureTextEntry = true
        }
        
        self.textField.setLeftPaddingPoints(15)
    }
    
    private func setPlaceholder() {
        let placeholder = NSAttributedString (
            string: textFieldType.placeholder,
            attributes: [
                .foregroundColor: UIColor.tvingGray2,
                .font: UIFont.Font(.regular, size: 15)
            ]
        )
        textField.attributedPlaceholder = placeholder
    }
    
    private func showButtonWhenEditingTextField() {
        stackView.isHidden = false
        textField.layer.borderColor = UIColor.tvingGray2.cgColor
        textField.layer.borderWidth = 1.0
        setPlaceholder()
    }
    
    private func hideButtonWhenEditingTextField() {
        stackView.isHidden = true
        textField.backgroundColor = .tvingGray4
        textField.layer.borderColor = UIColor.clear.cgColor
        textField.placeholder = nil
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

extension CustomTextField : UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        showButtonWhenEditingTextField()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        hideButtonWhenEditingTextField()
    }
}
