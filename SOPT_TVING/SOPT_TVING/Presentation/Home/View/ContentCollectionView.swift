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
    
    private let collectionViewFlowLayout = UICollectionViewFlowLayout().then {
        $0.minimumInteritemSpacing = 8
        $0.scrollDirection = .horizontal
        $0.itemSize = .init(width: 100, height: 200)
    }
    
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
        contentView.addSubviews(contentCollectionView)
        
        contentCollectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
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
