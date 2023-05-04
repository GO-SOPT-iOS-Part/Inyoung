//
//  MenuCollectionViewCell.swift
//  SOPT_TVING
//
//  Created by 김인영 on 2023/05/03.
//

import UIKit

class MenuCollectionViewCell: UICollectionViewCell {
    
    override var isHighlighted : Bool {
        didSet {
            menuUnderLineView.backgroundColor = isSelected ? .tvingWhite : .clear
            UIView.animate(withDuration: 0.3,
                           delay: 0,
                           options: .curveEaseOut,
                           animations: {
                self.menuUnderLineView.layoutIfNeeded()
                self.menuUnderLineView.alpha = self.isSelected ? 1 : 0.1
            }, completion: nil)
        }
    }
    
    override var isSelected: Bool {
        didSet {
            menuUnderLineView.backgroundColor = isSelected ? .tvingWhite : .clear
            UIView.animate(withDuration: 0.3,
                           delay: 0,
                           options: .curveEaseOut,
                           animations: {
                self.menuUnderLineView.layoutIfNeeded()
                self.menuUnderLineView.alpha = self.isSelected ? 1 : 0.1
            }, completion: nil)
        }
    }
    
    private var menuLabel = UILabel().then {
        $0.font = .Font(.regular, size: 17)
        $0.textColor = .tvingWhite
    }
    
    private let menuUnderLineView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayout()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MenuCollectionViewCell {
    
    private func setLayout() {
        
        contentView.addSubviews(menuLabel, menuUnderLineView)
        
        menuLabel.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
        }
        
        menuUnderLineView.snp.updateConstraints {
            $0.bottom.equalToSuperview()
            $0.centerX.equalToSuperview()
            $0.height.equalTo(2)
            $0.width.equalTo(menuLabel.snp.width)
        }
    }
    
    func dataBind(menuLabel: String) {
        self.menuLabel.text = menuLabel
    }
}
