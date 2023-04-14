//
//  ViewController.swift
//  SoptSeminar
//
//  Created by 김인영 on 2023/04/01.
//

import UIKit

import SnapKit

final class FirstViewController: UIViewController {
    
    // MARK: = Properties
    
    private var name: String = ""
    
    // MARK: - UI Components
    
    private let containerView = UIView()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "이름을 입력해주세요"
        label.font = .systemFont(ofSize: 20)
        label.textColor = .black
        return label
    }()
    
    private lazy var nameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "이름을 입력해주세요"
        textField.clearButtonMode = .whileEditing
        textField.layer.borderColor = UIColor.gray.cgColor
        textField.layer.borderWidth = 1
        textField.delegate = self
        textField.addTarget(self, action: #selector(textFieldDidEndEditing), for: .editingChanged)
        return textField
    }()
    
    private lazy var presentButton: UIButton = {
        let button = UIButton()
        button.setTitle("present!", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.isEnabled = false
        button.addTarget(self, action: #selector(presentButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var pushButton: UIButton = {
        let button = UIButton()
        button.setTitle("push!", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.isEnabled = false
        button.addTarget(self, action: #selector(pushButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private let errorLabel: UILabel = {
       let label = UILabel()
        label.text = "이름이 입력되지 않았습니다."
        label.textColor = .red
        label.font = .systemFont(ofSize: 15)
        label.isHidden = true
        return label
    }()
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        setLayout()
        addKeyboardObserver()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    //MARK: - Methods
    
    private func addKeyboardObserver() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil)
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide),
            name: UIResponder.keyboardWillHideNotification,
            object: nil)
    }
    
    @objc private func keyboardWillShow(_ notification: NSNotification) {
        guard let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else {
            return
        }
        let keyboardHeight = keyboardFrame.height
        let containerViewMaxY = containerView.frame.maxY
        let screenHeight = UIScreen.main.bounds.height
        let distance = keyboardHeight - (screenHeight - containerViewMaxY)
        
        UIView.animate(withDuration: 0.25) {
            self.view.frame.origin.y = distance > 0 ? -distance : 0
        }
    }
    
    @objc private func keyboardWillHide() {
        UIView.animate(withDuration: 0.25) {
            self.view.frame.origin.y = 0
        }
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
        super.touchesBegan(touches, with: event)
    }
    
    func presentToSecondViewController() {
        let secondVC = SecondViewController()
        secondVC.modalPresentationStyle = .fullScreen
        secondVC.getUserName(name: name)
        self.present(secondVC, animated: true)
    }
    
    func pushToSecondViewController() {
        let secondVC = SecondViewController()
        secondVC.getUserName(name: name)
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

// MARK: - UI & Layout

private extension FirstViewController {
    
    func setUI() {
        view.backgroundColor = .white
        
        nameTextField.setLeftPaddingPoints(15)
    }
    
    func setLayout() {
        view.addSubviews(containerView)
        
        containerView.addSubviews(nameLabel, nameTextField, errorLabel, presentButton, pushButton)
        
        containerView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(400)
            $0.leading.trailing.equalToSuperview().inset(30)
            $0.height.equalTo(250)
        }
        
        nameLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.centerX.equalToSuperview()
        }
        
        nameTextField.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(48)
        }
        
        errorLabel.snp.makeConstraints {
            $0.top.equalTo(nameTextField.snp.bottom).offset(5)
            $0.trailing.equalTo(nameTextField)
        }
        
        presentButton.snp.makeConstraints {
            $0.top.equalTo(nameTextField.snp.bottom).offset(30)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(40)
        }
        
        pushButton.snp.makeConstraints {
            $0.top.equalTo(presentButton.snp.bottom).offset(20)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(48)
        }
    }
    
    private func setupLayoutForEmptyName() {
        errorLabel.isHidden = false
        presentButton.isEnabled = false
        pushButton.isEnabled = false
    }
    
    private func setupLayoutForNonEmptyName() {
        errorLabel.isHidden = true
        presentButton.isEnabled = true
        pushButton.isEnabled = true
    }
}

// MARK: - UITextFieldDelegate

extension FirstViewController : UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let name = nameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) {
            self.name = name
        }
        
        name.isEmpty ? setupLayoutForEmptyName() : setupLayoutForNonEmptyName()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder() // TextField 비활성화
        return true
    }
}
