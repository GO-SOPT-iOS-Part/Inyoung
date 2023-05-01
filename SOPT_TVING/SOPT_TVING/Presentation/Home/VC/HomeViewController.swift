//
//  HomeViewController.swift
//  SOPT_TVING
//
//  Created by 김인영 on 2023/05/01.
//

import UIKit

import SnapKit
import Then

final class HomeViewController: UIViewController {

    // MARK: - Properties
    
    // MARK: - UI Components
    
    private lazy var tableView = UITableView().then {
        $0.showsVerticalScrollIndicator = true
        $0.backgroundColor = .tvingBlack
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.allowsSelection = false
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCells()
        setDelegate()
        setLayout()
    }
    
    private func registerCells() {
        tableView.register(HomeHeaderView.self, forHeaderFooterViewReuseIdentifier: HomeHeaderView.className)
        tableView.register(HomeTableViewCell.self, forCellReuseIdentifier: HomeTableViewCell.className)
    }
    
    private func setDelegate() {
        tableView.delegate = self
        tableView.dataSource = self
    }
}

// MARK: - UI & Layout

extension HomeViewController {
    
    private func setLayout() {
        view.addSubviews(tableView)
        
        tableView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
        }
    }
}

// MARK: - TableView Delegate

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HomeTableViewCell.className, for: indexPath) as? HomeTableViewCell else { return UITableViewCell() }
        cell.backgroundColor = .clear
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: HomeHeaderView.className) as? HomeHeaderView else { return nil }
        view.profileButtonTappedClosure = {[weak self] in
            let myPageVC = MyPageViewController()
            myPageVC.hidesBottomBarWhenPushed = true
            self?.navigationController?.pushViewController(myPageVC, animated: true)
        }
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
}
