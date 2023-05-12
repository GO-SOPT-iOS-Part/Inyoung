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
    
    // MARK: - Properties
    
    private var nowPlayingMovie: [MovieListModel] = []
    
    private let contentTitleLabel = UILabel().then {
        $0.text = "티빙에서 꼭 봐야하는 컨텐츠"
        $0.font = .Font(.semiBold, size: 15)
        $0.textColor = .tvingWhite
    }
    
    private let totalButton = UIButton().then {
        $0.setTitle("전체보기", for: .normal)
        $0.setTitleColor(UIColor.tvingGray3, for: .normal)
        $0.titleLabel?.font = .Font(.medium, size: 13)
    }
    
    private let collectionViewFlowLayout = UICollectionViewFlowLayout().then {
        $0.minimumInteritemSpacing = 8
        $0.scrollDirection = .horizontal
        $0.itemSize = .init(width: 120, height: 240)
    }
    
    // MARK: - UI Components
    
    private lazy var contentCollectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewFlowLayout).then {
        $0.showsHorizontalScrollIndicator = false
        $0.isScrollEnabled = true
        $0.backgroundColor = .tvingBlack
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
    
    func setData(data: [MovieListModel]) {
        self.nowPlayingMovie = data
        self.contentCollectionView.reloadData() // 영화 목록 반영
    }
}

extension ContentCollectionView {
    private func setLayout() {
        contentView.backgroundColor = .tvingBlack
        contentView.addSubviews(contentTitleLabel, totalButton, contentCollectionView)
        
        contentTitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().offset(15)
        }
        
        totalButton.snp.makeConstraints {
            $0.centerY.equalTo(contentTitleLabel)
            $0.trailing.equalToSuperview().inset(15)
        }
        
        contentCollectionView.snp.makeConstraints {
            $0.top.equalTo(contentTitleLabel.snp.bottom).offset(14)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
}

extension ContentCollectionView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return nowPlayingMovie.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ContentCVC.className, for: indexPath) as? ContentCVC else { return UICollectionViewCell() }
        cell.dataBind(data: nowPlayingMovie[indexPath.item])
        return cell
    }
}
