//
//  MyPageFooterView.swift
//  SOPT_TVING
//
//  Created by 김인영 on 2023/05/02.
//

import UIKit

import SnapKit
import Then

class MyPageFooterView: UITableViewHeaderFooterView {
    
    enum FooterType : CaseIterable {
        case separate
        case logout
    }
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUI(style: FooterType) {
        switch style {
        case.separate:
            self.setSeparateView()
        case.logout:
            self.setLogoutView()
        }
    }
}

extension MyPageFooterView {
    
    private func setSeparateView() {
        let separateView = UIView().then {
            $0.backgroundColor = .tvingGray4
        }
        
        contentView.addSubview(separateView)
        separateView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(8)
            $0.height.equalTo(1)
        }
    }
    
    private func setLogoutView() {
        lazy var logoutButton = UIButton().then {
            $0.setTitle("로그아웃", for: .normal)
            $0.setTitleColor(UIColor.tvingGray2, for: .normal)
            $0.titleLabel?.font = .Font(.medium, size: 14)
            $0.backgroundColor = .tvingBlack
            $0.layer.cornerRadius = 2
            $0.layer.borderColor = UIColor.tvingGray4.cgColor
            $0.layer.borderWidth = 1
        }
        
        contentView.addSubview(logoutButton)
        logoutButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(23)
            $0.leading.trailing.equalToSuperview().inset(8)
            $0.height.equalTo(55)
        }
    }
}
