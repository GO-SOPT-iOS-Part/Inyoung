//
//  FirstViewController_DelegatePattern.swift
//  SoptSeminar
//
//  Created by 김인영 on 2023/04/08.
//

import UIKit

final class FirstViewController_DelegatePattern: UIViewController {
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "이름이 무엇인가요!?"
        label.font = .systemFont(ofSize: 16)
        label.textColor = .blue
        label.textAlignment = .center
        return label
    }()
    
    private lazy var nextButton: UIButton = {
        let button = UIButton()
        button.setTitle("다음으로!", for: .normal)
        button.backgroundColor = .yellow
        button.setTitleColor(.blue, for: .normal)
        button.addTarget(self,
                         action: #selector(pushToSecondViewController),
                         for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        style()
        setLayout()
    }
}

private extension FirstViewController_DelegatePattern {
 
    func style() {
        
        view.backgroundColor = .white
    }
    
    func setLayout() {
        
        [nameLabel, nextButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
        
        NSLayoutConstraint.activate([nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                                     nameLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)])
    
        
        NSLayoutConstraint.activate([nextButton.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 20),
                                     nextButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
                                     nextButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
                                     nextButton.heightAnchor.constraint(equalToConstant: 48)])
    }
    
    @objc
    func pushToSecondViewController() {
        
        let secondViewController = SecondViewController_DelegatePattern()
        secondViewController.delegate = self
        self.navigationController?.pushViewController(secondViewController, animated: true)
    }
}

extension FirstViewController_DelegatePattern: DataBindProtocol {
    
    func dataBind(text: String) {
        
        nameLabel.text = text
    }
}
