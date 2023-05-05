//
//  HomeTabViewController.swift
//  SOPT_TVING
//
//  Created by 김인영 on 2023/05/03.
//

import UIKit

import SnapKit
import Then

class HomeViewController: UIViewController {
    
    private let collectionViewFlowLayout = UICollectionViewFlowLayout()
    private lazy var topPosterCollectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewFlowLayout).then {
        $0.showsHorizontalScrollIndicator = false
        $0.isPagingEnabled = true
    }
    
    private let dataSource: [UIColor] = [.red, .orange, .yellow, .green, .blue]
    private lazy var increasedDataSource: [UIColor] = {
        dataSource + dataSource + dataSource
    }()
    private var originalDataSourceCount: Int {
        dataSource.count
    }
    
    // MARK: - Control Property
    
    private var scrollToEnd: Bool = false
    private var scrollToBegin: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCells()
        setLayout()
        setDelegate()
        setUI()
        setPosterScroll()
    }
    private func setDelegate() {
        topPosterCollectionView.delegate = self
        topPosterCollectionView.dataSource = self
    }
    
    private func registerCells() {
        topPosterCollectionView.register(TopPosterCollectionViewCell.self, forCellWithReuseIdentifier: TopPosterCollectionViewCell.className)
    }
}

extension HomeViewController {
    private func setUI() {
        view.backgroundColor = .tvingBlack
        topPosterCollectionView.backgroundColor = .tvingGray1
        
        collectionViewFlowLayout.scrollDirection = .horizontal
    }
    
    private func setLayout() {
        view.addSubviews(topPosterCollectionView)
        
        topPosterCollectionView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(500)
        }
    }
    
    private func setPosterScroll() {
        topPosterCollectionView.scrollToItem(at: IndexPath(item: originalDataSourceCount, section: 0),
                                             at: .centeredHorizontally,
                                             animated: true)
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return originalDataSourceCount * 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TopPosterCollectionViewCell.className, for: indexPath) as? TopPosterCollectionViewCell else { return UICollectionViewCell() }
        cell.backgroundColor = increasedDataSource[indexPath.item]
        return cell
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.bounds.width, height: 500)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

extension HomeViewController: UIScrollViewDelegate {
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
