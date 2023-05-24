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
        $0.layer.cornerRadius = 5
    }
    private let posterName = UILabel().then {
        $0.text = "영화 이름"
        $0.font = .Font(.medium, size: 12)
        $0.textColor = .tvingGray2
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func dataBind(data: MovieListModel) {
        posterName.text = data.title
        posterImageView.getImageFromURL(data.imageURL)
    }
}

extension ContentCVC {
    
    private func setUI() {
        backgroundColor = .tvingBlack
    }
    
    private func setLayout() {
        contentView.addSubviews(posterImageView, posterName)
        
        posterImageView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(200)
        }
        
        posterName.snp.makeConstraints {
            $0.top.equalTo(posterImageView.snp.bottom).offset(3)
            $0.leading.trailing.equalToSuperview()
        }
    }
}
