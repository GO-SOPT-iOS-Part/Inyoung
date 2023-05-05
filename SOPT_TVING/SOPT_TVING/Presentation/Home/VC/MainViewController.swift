//
//  HomeViewController.swift
//  SOPT_TVING
//
//  Created by 김인영 on 2023/05/01.
//

import UIKit

import SnapKit
import Then

final class MainViewController: UIViewController {

    // MARK: - Properties
    
    var menuName : [String] = ["홈", "실시간", "TV프로그램", "영화", "파라마운트+"]
    
    private let homeVC = HomeViewController()
    private let streamingVC = StreamingViewController()
    private let tvProgramVC = TVProgramViewController()
    private let movieVC = MovieViewController()
    private let paramountVC = ParamountViewController()
    
    lazy var dataViewControllers: [UIViewController] = {
        return [homeVC, streamingVC, tvProgramVC, movieVC, paramountVC]
    }()
    
    var currentPage: Int = 0 {
        didSet {
            bind(newValue: currentPage)
        }
    }
    
    // MARK: - UI Components
    
    private let scrollView = UIScrollView()
    private let naviBar = NaviView()
    private let layout : UICollectionViewFlowLayout = UICollectionViewFlowLayout().then {
        $0.scrollDirection = .horizontal
    }
    private lazy var menuCollectionView : UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout).then {
        $0.backgroundColor = .clear
        $0.showsHorizontalScrollIndicator = false
        $0.isScrollEnabled = true
        $0.allowsMultipleSelection = false
        $0.delegate = self
        $0.dataSource = self
    }
    lazy var pageViewController: UIPageViewController = {
        let vc = UIPageViewController(transitionStyle: .scroll,
                                      navigationOrientation: .horizontal,
                                      options: nil)
        vc.view.backgroundColor = .clear
        return vc
    }()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLayout()
        registerCells()
        setupDelegate()
        setFirstIndexSelected()
        tabMyProfileImage()
        scrollView.backgroundColor = .tvingBlack
    }
    
    private func registerCells() {
        menuCollectionView.register(MenuCollectionViewCell.self, forCellWithReuseIdentifier: MenuCollectionViewCell.className
        )
    }
    
    private func setupDelegate() {
        scrollView.delegate = self
        
        pageViewController.dataSource = self
        pageViewController.delegate = self
    }
    
    private func setFirstIndexSelected() {
        let selectedIndexPath = IndexPath(item: 0, section: 0)
        menuCollectionView.selectItem(at: selectedIndexPath,
                                      animated: true,
                                      scrollPosition: .bottom)
        
        if let firstVC = dataViewControllers.first {
            pageViewController.setViewControllers([firstVC],
                                                  direction: .forward,
                                                  animated: true,
                                                  completion: nil)
        }
    }
    
    private func didTapCell(at indexPath: IndexPath) {
        currentPage = indexPath.item
    }
    
    private func bind(newValue: Int) {
        menuCollectionView.selectItem(at: IndexPath(item: currentPage, section: 0),
                                      animated: true,
                                      scrollPosition: .centeredHorizontally)
    }
    
    private func tabMyProfileImage() {
        naviBar.profileButtonTappedClosure = {[weak self] in
            let myPageVC = MyPageViewController()
            myPageVC.hidesBottomBarWhenPushed = true
            self?.navigationController?.pushViewController(myPageVC, animated: true)
        }
    }
}

// MARK: - UI & Layout

extension MainViewController {
    
    private func setLayout() {
        view.addSubviews(scrollView)
        scrollView.addSubviews(pageViewController.view, naviBar, menuCollectionView)
        
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let topInset = windowScene.windows.first?.safeAreaInsets.top else { return }
        
        scrollView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide)
        }
        
        pageViewController.view.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalToSuperview().offset(41+50)
            $0.bottom.equalToSuperview()
        }
        
        menuCollectionView.snp.makeConstraints {
            $0.top.equalTo(naviBar.snp.bottom)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(41)
        }
        
        naviBar.snp.makeConstraints {
            $0.top.equalToSuperview().offset(topInset)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(50)
        }
    }
}

// MARK: - ScrollView Delegate

extension MainViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let topInset = windowScene.windows.first?.safeAreaInsets.top else { return }
        if offsetY > topInset {
            let translation = CGAffineTransform(translationX: 0, y: offsetY - topInset)
            menuCollectionView.transform = translation
            menuCollectionView.backgroundColor = .tvingBlack.withAlphaComponent(0.8)
            scrollView.contentInsetAdjustmentBehavior = .scrollableAxes
        } else if offsetY > 0 {
            naviBar.isHidden  = true
        } else {
            let translation = CGAffineTransform(translationX: 0, y: 0)
            menuCollectionView.transform = translation
            menuCollectionView.backgroundColor = .clear
            naviBar.isHidden = false
            scrollView.contentInsetAdjustmentBehavior = .never
        }
    }
}

// MARK: - CollectionView Delegate & DataSource

extension MainViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return menuName.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MenuCollectionViewCell.className, for: indexPath) as? MenuCollectionViewCell else { return UICollectionViewCell() }
        cell.dataBind(menuLabel: menuName[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if currentPage < indexPath.item {
            pageViewController.setViewControllers([dataViewControllers[indexPath.item]],
                                                  direction: .forward,
                                                  animated: true,
                                                  completion: nil)
        } else {
            pageViewController.setViewControllers([dataViewControllers[indexPath.item]],
                                                  direction: .reverse,
                                                  animated: true,
                                                  completion: nil)
        }
        didTapCell(at: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: menuName[indexPath.item].size(withAttributes: [NSAttributedString.Key.font : UIFont.Font(.regular, size: 17)]).width + 28, height: 37)
    }
}

// MARK: - PageViewController Delegate & DataSource

extension MainViewController : UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = dataViewControllers.firstIndex(of: viewController) else { return nil }
        let previousIndex = index - 1
        if previousIndex < 0 {
            return nil
        }
        return dataViewControllers[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        guard let currentVC = pageViewController.viewControllers?.first,
              let currentIndex = dataViewControllers.firstIndex(of: currentVC) else { return }
        currentPage = currentIndex
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = dataViewControllers.firstIndex(of: viewController) else { return nil }
        let nextIndex = index + 1
        if nextIndex == dataViewControllers.count {
            return nil
        }
        return dataViewControllers[nextIndex]
    }
}
