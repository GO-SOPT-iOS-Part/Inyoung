//
//  TabBarViewController.swift
//  SOPT_TVING
//
//  Created by 김인영 on 2023/05/01.
//

import UIKit

final class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setViewControllers()
        setTabBar()
    }
    
    private func setViewControllers() {
        
        let homeVC = makeNavigationController(
            
            unselectedImage: ImageLiterals.TabBar.home,
            selectedImage: ImageLiterals.TabBar.homeSelected,
            rootViewController: HomeViewController(), title: "홈")
        
        let upcomingVC = makeNavigationController(
            unselectedImage: ImageLiterals.TabBar.upcoming,
            selectedImage: ImageLiterals.TabBar.upcomingSelected,
            rootViewController: UpcomingViewController(), title: "공개예정")
        
        let searchVC = makeNavigationController(
            unselectedImage: ImageLiterals.TabBar.search,
            selectedImage: ImageLiterals.TabBar.search,
            rootViewController: SearchViewController(), title: "검색")
        
        let recordVC = makeNavigationController(
            unselectedImage: ImageLiterals.TabBar.record,
            selectedImage: ImageLiterals.TabBar.recrodSelected,
            rootViewController: RecordViewController(), title: "기록")
        
        viewControllers = [homeVC, upcomingVC, searchVC, recordVC]
    }
    
    private func makeNavigationController(unselectedImage: UIImage?, selectedImage: UIImage?, rootViewController: UIViewController, title: String) -> UINavigationController {
        
        let nav = UINavigationController(rootViewController: rootViewController)
        nav.tabBarItem.image = unselectedImage
        nav.tabBarItem.selectedImage = selectedImage
        nav.tabBarItem.title = title
        
        nav.navigationBar.tintColor = .black
        nav.navigationBar.backgroundColor = .white
        nav.isNavigationBarHidden = true
        nav.navigationBar.isHidden = true
        nav.tabBarItem.setTitleTextAttributes([.font: UIFont.Font(.regular, size: 13)], for: .normal)
        nav.navigationItem.backBarButtonItem = UIBarButtonItem(title: nil, style: .plain, target: self, action: nil)
        nav.navigationItem.backBarButtonItem?.tintColor = .black
        
        nav.interactivePopGestureRecognizer?.isEnabled = true
        nav.interactivePopGestureRecognizer?.delegate = self
        return nav
    }
    
    private func setTabBar() {
        tabBar.backgroundColor = .tvingBlack
        tabBar.tintColor = .tvingWhite
        tabBar.unselectedItemTintColor = .tvingGray3
    }
}

extension TabBarController: UIGestureRecognizerDelegate { }

