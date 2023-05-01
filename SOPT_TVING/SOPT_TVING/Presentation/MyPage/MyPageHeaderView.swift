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
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .tvingBlack
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
