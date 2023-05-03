//
//  MyPageTableViewCell.swift
//  SOPT_TVING
//
//  Created by 김인영 on 2023/05/02.
//

import UIKit

import SnapKit
import Then

final class MyPageTableViewCell: UITableViewCell {

    let label = UILabel().then {
        $0.font = .Font(.medium, size: 15)
        $0.textColor = .tvingGray2
    }
    
    private lazy var moreInfoButton = UIButton().then {
        $0.setImage(ImageLiterals.Icn.moreInfo, for: .normal)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setBackgroundColor()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func dataBind(text: String) {
        label.text = text
    }
}

extension MyPageTableViewCell {
    
    private func setBackgroundColor() {
        contentView.backgroundColor = .tvingBlack
    }
    
    private func setLayout() {
        contentView.addSubviews(label, moreInfoButton)
        
        label.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(18)
        }
        
        moreInfoButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(18)
            $0.height.width.equalTo(30)
        }
    }
}
