//
//  SecondViewController.swift
//  SoptSeminar
//
//  Created by 김인영 on 2023/04/07.
//

import UIKit
import SnapKit

final class SecondViewController: UIViewController {
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "제 이름은요!"
        label.font = .boldSystemFont(ofSize: 35)
        return label
    }()
    
    private lazy var backButton: UIButton = {
        let button = UIButton()
        button.setTitle("뒤로가기", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 20)
        button.addTarget(self,
                         action: #selector(backButtonTapped),
                         for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        style()
        setLayout()
    }
    
    @objc
    func backButtonTapped() {
        if self.navigationController == nil {
            self.dismiss(animated: true, completion: nil)
        } else {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    func getUserName(name: String){
        nameLabel.text = "\(name)님 환영합니다"
    }
}

private extension SecondViewController {
    
    func style() {
        view.backgroundColor = .white
    }
    
    func setLayout() {
        view.addSubviews(nameLabel, backButton)
        
        nameLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        backButton.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom).offset(40)
            $0.centerX.equalToSuperview().inset(30)
            $0.height.equalTo(48)
        }
    }
}
