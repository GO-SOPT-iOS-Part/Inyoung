//
//  HomeHeaderView.swift
//  SOPT_TVING
//
//  Created by 김인영 on 2023/05/01.
//

import UIKit

import SnapKit
import Then

final class HomeHeaderView: UITableViewHeaderFooterView {
    
    var profileButtonTappedClosure: (()-> Void)?
    
    private let containerView = UIView()
    private let tvingLogoImageView = UIImageView(image: ImageLiterals.Logo.logoImageWhite)
    private let airPlayButton = UIButton().then {
        $0.tintColor = .tvingWhite
        $0.setImage(UIImage(systemName: "airplayvideo"), for: .normal)
    }
    private lazy var myProfileButton = UIButton().then {
        $0.setImage(ImageLiterals.Sample.profileImage, for: .normal)
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 15
        $0.addTarget(self, action: #selector(profileButtonDidTap), for: .touchUpInside)
    }
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setLayout()
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc
    private func profileButtonDidTap() {
        profileButtonTappedClosure?()
    }
}

extension HomeHeaderView {
    
    private func setUI() {
        containerView.backgroundColor = .tvingBlack
    }
    
    private func setLayout() {
        addSubviews(containerView)
        containerView.addSubviews(tvingLogoImageView, airPlayButton, myProfileButton)
        
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        tvingLogoImageView.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(11)
            $0.centerY.equalToSuperview()
            $0.width.equalTo(99)
            $0.height.equalTo(25)
        }
        
        myProfileButton.snp.makeConstraints {
            $0.trailing.bottom.equalToSuperview().inset(11)
            $0.height.width.equalTo(30)
        }
        
        airPlayButton.snp.makeConstraints {
            $0.trailing.equalTo(myProfileButton.snp.leading).offset(-11)
            $0.bottom.equalTo(myProfileButton)
            $0.height.width.equalTo(30)
        }
    }
}
