//
//  TopPosterTableView.swift
//  SOPT_TVING
//
//  Created by 김인영 on 2023/05/11.
//

import UIKit

import SnapKit
import Then

class TopPosterCollectionView: UITableViewCell {

    private let dataSource: [UIColor] = [.black, .orange, .yellow, .green, .blue]
    private lazy var increasedDataSource: [UIColor] = {
        dataSource + dataSource + dataSource
    }()
    private var originalDataSourceCount: Int {
        dataSource.count
    }
    
    private var scrollToEnd: Bool = false
    private var scrollToBegin: Bool = false
    
    private let collectionViewFlowLayout = UICollectionViewFlowLayout().then {
        $0.scrollDirection = .horizontal
    }
    
    private lazy var topPosterCollectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewFlowLayout).then {
        $0.showsHorizontalScrollIndicator = false
        $0.isPagingEnabled = true
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setDelegate()
        registerCells()
        setLayout()
        setPosterScroll()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setDelegate() {
        topPosterCollectionView.delegate = self
        topPosterCollectionView.dataSource = self
    }
    
    private func registerCells() {
        topPosterCollectionView.register(TopPosterCVC.self, forCellWithReuseIdentifier: TopPosterCVC.className)
    }
    
    private func setLayout() {
        addSubviews(topPosterCollectionView)
        
        topPosterCollectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    private func setPosterScroll() {
        collectionViewFlowLayout.itemSize = CGSize(width: UIScreen.main.bounds.width, height: 500)
        topPosterCollectionView.collectionViewLayout = collectionViewFlowLayout
        topPosterCollectionView.scrollToItem(at: IndexPath(item: originalDataSourceCount, section: 0),
                                             at: .centeredHorizontally,
                                             animated: true)
    }
}

extension TopPosterCollectionView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return originalDataSourceCount * 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TopPosterCVC.className, for: indexPath) as? TopPosterCVC else { return UICollectionViewCell() }
        cell.backgroundColor = increasedDataSource[indexPath.item]
        return cell
    }
}

extension TopPosterCollectionView: UIScrollViewDelegate {
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let beginOffset = topPosterCollectionView.frame.width * CGFloat(originalDataSourceCount)
        let endOffset = topPosterCollectionView.frame.width * CGFloat(originalDataSourceCount * 2 - 1)
        
        if scrollView.contentOffset.x < beginOffset && velocity.x < .zero {
            scrollToEnd = true
        } else if scrollView.contentOffset.x > endOffset && velocity.x > .zero {
            scrollToBegin = true
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if scrollToBegin {
            topPosterCollectionView.scrollToItem(at: IndexPath(item: originalDataSourceCount, section: .zero),
                                                at: .centeredHorizontally,
                                                animated: false)
            scrollToBegin.toggle()
            return
        }
        if scrollToEnd {
            topPosterCollectionView.scrollToItem(at: IndexPath(item: originalDataSourceCount * 2 - 1 , section: .zero),
                                                at: .centeredHorizontally,
                                      
                                            animated: false)
            scrollToEnd.toggle()
            return
        }
    }
}
