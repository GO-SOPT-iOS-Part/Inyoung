//
//  ContentCVC.swift
//  SOPT_TVING
//
//  Created by 김인영 on 2023/05/11.
//

import UIKit

class ContentCVC: UICollectionViewCell {
    
    private let posterImageView = UIImageView().then {
        $0.image = ImageLiterals.Sample.posterImage1
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 3
    }
    private let posterName = UILabel().then {
        $0.text = "영화 이름"
        $0.font = .Font(.medium, size: 10)
        $0.textColor = .tvingGray2
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ContentCVC {
    
    private func setLayout() {
        contentView.addSubviews(posterImageView, posterName)
        
        posterImageView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(145)
        }
        
        posterName.snp.makeConstraints {
            $0.top.equalTo(posterImageView.snp.bottom).offset(3)
            $0.leading.equalToSuperview()
        }
    }
}
