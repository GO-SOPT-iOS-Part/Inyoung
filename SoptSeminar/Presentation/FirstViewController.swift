//
//  ViewController.swift
//  SoptSeminar
//
//  Created by 김인영 on 2023/04/01.
//

import UIKit
import SnapKit

final class FirstViewController: UIViewController {
    
    // MARK: - UI Components
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "이름이 무엇인가요!?"
        label.font = .systemFont(ofSize: 16)
        label.textColor = .blue
        label.textAlignment = .center
        return label
    }()
    
    private let nameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "이름을 입력해주세요"
        textField.clearButtonMode = .whileEditing
        textField.layer.borderColor = UIColor.gray.cgColor
        textField.layer.borderWidth = 1
        return textField
    }()
    
    private let presentButton: UIButton = {
        let button = UIButton()
        button.setTitle("present!", for: .normal)
        button.backgroundColor = .yellow
        button.setTitleColor(.blue, for: .normal)
        return button
    }()
    
    private let pushButton: UIButton = {
        let button = UIButton()
        button.setTitle("push!", for: .normal)
        button.backgroundColor = .yellow
        button.setTitleColor(.blue, for: .normal)
        return button
    }()
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        style()
        setLayout()
    }
    
    //MARK: - Methods
    
    func presentToSecondViewController() {
        let secondVC = SecondViewController()
        secondVC.modalPresentationStyle = .fullScreen
        self.present(secondVC, animated: true)
    }
    
    func pushToSecondViewController() {
        let secondVC = SecondViewController()
        self.navigationController?.pushViewController(secondVC, animated: true)
    }
    
    @objc
    func presentButtonTapped() {
        presentToSecondViewController()
    }
    
    @objc
    func pushButtonTapped() {
        pushToSecondViewController()
    }
}

private extension FirstViewController {
    
    func style() {
        view.backgroundColor = .white
    }
    
    func setLayout() {
        
        view.addSubviews(nameLabel, nameTextField, presentButton, pushButton)
        
        nameLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(300)
            $0.centerX.equalToSuperview()
        }
        
        nameTextField.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom).offset(20)
            $0.centerX.equalToSuperview().inset(30)
            $0.height.equalTo(48)
        }
        
        presentButton.snp.makeConstraints {
            $0.top.equalTo(nameTextField.snp.bottom).offset(20)
            $0.centerX.equalToSuperview().inset(30)
            $0.height.equalTo(40)
        }
        
        pushButton.snp.makeConstraints {
            $0.top.equalTo(presentButton.snp.bottom).offset(20)
            $0.centerX.equalToSuperview().inset(30)
            $0.height.equalTo(48)
        }
    }
}
