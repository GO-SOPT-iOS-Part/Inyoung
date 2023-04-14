//
//  TouchViewController.swift
//  SoptSeminar
//
//  Created by 김인영 on 2023/04/08.
//

import UIKit
import SnapKit
import Then

class TouchViewController: UIViewController {

    private var count: Int = 0
    
    var completionHandler: ((Int) -> (Void))?
    
    private let countLabel = UILabel().then {
        $0.textColor = .darkGray
        $0.font = .systemFont(ofSize: 20)
        $0.text = "횟수는?!"
    }
    
    private lazy var touchMeButton = UIButton().then {
        $0.setTitle("누르쉿?", for: .normal)
        $0.backgroundColor = .systemBlue
        $0.setTitleColor(.white, for: .normal)
        $0.layer.cornerRadius = 10
        $0.addTarget(self, action: #selector(touchMeButtonDidTap), for: .touchUpInside)
    }
    
    private lazy var backButton = UIButton().then {
        $0.setTitle("뒤로가쉿?", for: .normal)
        $0.backgroundColor = .systemGray
        $0.setTitleColor(.white, for: .normal)
        $0.layer.cornerRadius = 10
        $0.addTarget(self, action: #selector(backButtonDidTap), for: .touchUpInside)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setLayout()
    }
    
    @objc func touchMeButtonDidTap() {
        self.count += 1
        print(count)
    }
    
    @objc func backButtonDidTap() {
        self.dismiss(animated: true)
        completionHandler?(count)
    }
}

extension TouchViewController {
    
    private func setUI() {
        view.backgroundColor = .white
    }
    
    private func setLayout() {
        view.addSubviews(countLabel, touchMeButton, backButton)
        
        countLabel.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
        }
        
        touchMeButton.snp.makeConstraints {
            $0.top.equalTo(countLabel.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview().inset(100)
            $0.height.equalTo(40)
        }
        
        backButton.snp.makeConstraints {
            $0.top.equalTo(touchMeButton.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview().inset(100)
            $0.height.equalTo(40)
        }
    }
}
