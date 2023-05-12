//
//  MyPageHeaderView.swift
//  SOPT_TVING
//
//  Created by 김인영 on 2023/05/02.
//

import UIKit

import SnapKit
import Then

final class MyPageHeaderView: UITableViewHeaderFooterView {
    
    private let profileContainerView = UIView()
    private let profileImageView = UIImageView(image: ImageLiterals.Sample.profileImage)
    private let nameLabel = UILabel().then {
        $0.font = .Font(.medium, size: 17)
        $0.text = "뇽잉깅"
        $0.textColor = .tvingWhite
    }
    private let switchProfileButton = UIButton().then {
        $0.setTitle(StringLiterals.MyProfile.switchProfile, for: .normal)
        $0.setTitleColor(UIColor.tvingGray1, for: .normal)
        $0.titleLabel?.font = .Font(.medium, size: 10)
        $0.backgroundColor = .tvingBlack
        $0.layer.cornerRadius = 2
        $0.layer.borderColor = UIColor.tvingGray4.cgColor
        $0.layer.borderWidth = 1
    }
    
    private let myTicketCashContainerView = UIView()
    private let ticketImage = UIImageView(image: ImageLiterals.Icn.ticket)
    private let ticketLabel = UILabel().then {
        $0.text = StringLiterals.MyProfile.myTicket
        $0.font = .Font(.medium, size: 13)
        $0.textColor = .tvingGray3
    }
    private let myTicketStatusLabel = UILabel().then {
        $0.text = "사용중인 이용권이 없습니다."
        $0.font = .Font(.medium, size: 13)
        $0.textColor = .tvingGray3
    }
    private let cashImage = UIImageView(image: ImageLiterals.Icn.cash)
    private let cashLabel = UILabel().then {
        $0.text = StringLiterals.MyProfile.myCash
        $0.font = .Font(.medium, size: 13)
        $0.textColor = .tvingGray3
    }
    private let myCashStatusLabel = UILabel().then {
        $0.text = "0"
        $0.font = .Font(.bold, size: 15)
        $0.textColor = .tvingWhite
    }
    
    private let suggestMembershipButton = UIButton()
    private let suggestLabelContainerView = UIView()
    private let suggestLabel1 = UILabel().then {
        $0.text = "이용권을 구매하고"
        $0.font = .Font(.semiBold, size: 12)
        $0.textColor = .tvingGray2
    }
    private let tvnLogoImageView = UIImageView(image: ImageLiterals.Logo.logoTVN)
    private let jtbcLogoImageView = UIImageView(image: ImageLiterals.Logo.logoJTBC)
    private let suggestLabel2 = UILabel().then {
        $0.text = "등 인기 프로그램과"
        $0.font = .Font(.semiBold, size: 12)
        $0.textColor = .tvingGray2
    }
    private let suggestLabel3 = UILabel().then {
        $0.text = "다양한 영화 콘텐츠를 자유롭게 시청하세요!"
        $0.font = .Font(.semiBold, size: 12)
        $0.textColor = .tvingGray2
    }
    private lazy var moreInfoImageView = UIImageView(image: ImageLiterals.Icn.moreInfo)
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setUI()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MyPageHeaderView {
    
    private func setUI() {
        contentView.backgroundColor = .tvingBlack
        profileContainerView.backgroundColor = .tvingBlack
        myTicketCashContainerView.backgroundColor = .tvingGray5
        suggestMembershipButton.backgroundColor = .tvingGray5
        
        profileImageView.clipsToBounds = true
        myTicketCashContainerView.clipsToBounds = true
        
        profileImageView.layer.cornerRadius = 15
        myTicketCashContainerView.layer.cornerRadius = 3
        suggestMembershipButton.layer.cornerRadius = 3
    }
    
    private func setLayout() {
        addSubviews(profileContainerView, myTicketCashContainerView, suggestMembershipButton)
        
        profileContainerView.addSubviews(profileImageView, nameLabel, switchProfileButton)
        myTicketCashContainerView.addSubviews(ticketImage, ticketLabel, myTicketStatusLabel, cashImage, cashLabel, myCashStatusLabel)
        suggestMembershipButton.addSubviews(suggestLabelContainerView, moreInfoImageView)
        suggestLabelContainerView.addSubviews(suggestLabel1, tvnLogoImageView, jtbcLogoImageView, suggestLabel2, suggestLabel3)
        
        profileContainerView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(114)
        }
        
        profileImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(24)
            $0.size.equalTo(74)
        }
        
        nameLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(profileImageView.snp.trailing).offset(22)
        }
        
        switchProfileButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(24)
            $0.height.equalTo(25)
            $0.width.equalTo(70)
        }
        
        myTicketCashContainerView.snp.makeConstraints {
            $0.top.equalTo(profileContainerView.snp.bottom).offset(9)
            $0.leading.trailing.equalToSuperview().inset(10)
            $0.height.equalTo(92)
        }
        
        ticketImage.snp.makeConstraints {
            $0.top.equalToSuperview().inset(18)
            $0.leading.equalToSuperview().inset(11)
            $0.size.equalTo(23)
        }
        
        ticketLabel.snp.makeConstraints {
            $0.centerY.equalTo(ticketImage)
            $0.leading.equalTo(ticketImage.snp.trailing).offset(5)
        }
        
        myTicketStatusLabel.snp.makeConstraints {
            $0.centerY.equalTo(ticketLabel)
            $0.trailing.equalToSuperview().inset(11)
        }
        
        cashImage.snp.makeConstraints {
            $0.leading.equalTo(ticketImage)
            $0.bottom.equalToSuperview().inset(16)
            $0.size.equalTo(23)
        }
        
        cashLabel.snp.makeConstraints {
            $0.centerY.equalTo(cashImage)
            $0.leading.equalTo(ticketLabel)
        }
        
        myCashStatusLabel.snp.makeConstraints {
            $0.centerY.equalTo(cashLabel)
            $0.trailing.equalToSuperview().inset(13)
        }
        
        suggestMembershipButton.snp.makeConstraints {
            $0.top.equalTo(myTicketCashContainerView.snp.bottom).offset(12)
            $0.leading.trailing.equalToSuperview().inset(10)
            $0.height.equalTo(60)
        }
        
        suggestLabelContainerView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(18)
            $0.height.equalTo(38)
        }
        
        suggestLabel1.snp.makeConstraints {
            $0.top.leading.equalToSuperview()
        }
        
        tvnLogoImageView.snp.makeConstraints {
            $0.centerY.equalTo(suggestLabel1)
            $0.leading.equalTo(suggestLabel1.snp.trailing).offset(6)
            $0.width.equalTo(25)
            $0.height.equalTo(10)
        }
        
        jtbcLogoImageView.snp.makeConstraints {
            $0.centerY.equalTo(tvnLogoImageView)
            $0.leading.equalTo(tvnLogoImageView.snp.trailing).offset(5)
            $0.width.equalTo(23)
            $0.height.equalTo(12)
        }
        
        suggestLabel2.snp.makeConstraints {
            $0.leading.equalTo(jtbcLogoImageView.snp.trailing).offset(6)
            $0.centerY.equalTo(suggestLabel1)
        }
        
        suggestLabel3.snp.makeConstraints {
            $0.leading.equalTo(suggestLabel1)
            $0.bottom.equalToSuperview()
        }
        
        moreInfoImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(13)
            $0.size.equalTo(18)
        }
    }
}
