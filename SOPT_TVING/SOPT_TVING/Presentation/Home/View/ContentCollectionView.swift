//
//  ContentTVC.swift
//  SOPT_TVING
//
//  Created by 김인영 on 2023/05/11.
//

import UIKit

import SnapKit
import Then

final class ContentCollectionView: UITableViewCell {
    
    private let collectionViewFlowLayout = UICollectionViewFlowLayout().then {
        $0.minimumInteritemSpacing = 8
        $0.scrollDirection = .horizontal
        $0.itemSize = .init(width: 100, height: 200)
    }
    
    private lazy var contentCollectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewFlowLayout).then {
        $0.isScrollEnabled = true
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setLayout()
        registerCells()
        setDelegate()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func registerCells() {
        contentCollectionView.register(ContentCVC.self, forCellWithReuseIdentifier: ContentCVC.className)
    }
    
    private func setDelegate() {
        contentCollectionView.delegate = self
        contentCollectionView.dataSource = self
    }
}

extension ContentCollectionView {
    private func setLayout() {
        contentView.addSubviews(contentCollectionView)
        
        contentCollectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

extension ContentCollectionView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ContentCVC.className, for: indexPath) as? ContentCVC else { return UICollectionViewCell() }
        return cell
    }
}
