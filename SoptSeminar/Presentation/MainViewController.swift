//
//  MainViewController.swift
//  SoptSeminar
//
//  Created by 김인영 on 2023/04/08.
//

import UIKit
import SnapKit
import Then

class MainViewController: UIViewController {
    
    //MARK: - UI Components
    
    private let countLabel = UILabel().then {
        $0.textColor = .black
        $0.font = .systemFont(ofSize: 20)
        $0.text = "도전?"
    }
    
    private lazy var nextButton = UIButton().then {
        $0.setTitle("재도전하쉿?", for: .normal)
        $0.backgroundColor = .systemBlue
        $0.setTitleColor(.white, for: .normal)
        $0.layer.cornerRadius = 10
        $0.addTarget(self, action: #selector(nextButtonDidTap), for: .touchUpInside)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setLayout()
    }
    
    @objc private func nextButtonDidTap() {
        let nextVC = TouchViewController()
        nextVC.completionHandler = { [weak self] count in
            guard let self else { return }
            self.checkCount(count: count)
        }
        self.present(nextVC, animated: true)
    }
    
    private func checkCount(count: Int) {
        if count >= 10 {
            countLabel.text = "올 ㅋ \(count)번 누르쉿네요?"
        } else {
            countLabel.text = "I want more.. \(10 - count)번 더.."
        }
    }
}

// MARK: - UI Layout

extension MainViewController {
    private func setUI() {
        view.backgroundColor = .white
    }
    
    private func setLayout() {
        view.addSubviews(countLabel, nextButton)
        
        countLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        nextButton.snp.makeConstraints {
            $0.top.equalTo(countLabel.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(100)
            $0.height.equalTo(40)
            $0.width.equalTo(100)
        }
        
    }
}
