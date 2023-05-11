//
//  HomeTabViewController.swift
//  SOPT_TVING
//
//  Created by 김인영 on 2023/05/03.
//

import UIKit

import SnapKit
import Then

protocol HomeVCProtocol: AnyObject {
    func tableViewDidScroll(_ scrollView: UIScrollView)
}

class HomeVC: UIViewController {
    
    // MARK: - Properties
    
    weak var delegate: HomeVCProtocol?
    
    // MARK: - UI Components
    
    private lazy var tableView = UITableView(frame: .zero, style: .grouped).then {
        $0.showsVerticalScrollIndicator = true
        $0.backgroundColor = .tvingBlack
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.allowsSelection = false
        $0.separatorStyle = .none
        $0.delegate = self
        $0.dataSource = self
    }
    
    // MARK: - Control Property
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCells()
        setLayout()
        setUI()
    }
    private func registerCells() {
        tableView.register(TopPosterCollectionView.self, forCellReuseIdentifier: TopPosterCollectionView.className)
        tableView.register(ContentCollectionView.self, forCellReuseIdentifier: ContentCollectionView.className)
    }
}


extension HomeVC {
    private func setUI() {
        view.backgroundColor = .tvingBlack
    }
    
    private func setLayout() {
        view.addSubviews(tableView)
        
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

extension HomeVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 500
        } else {
            return 200
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: TopPosterCollectionView.className, for: indexPath) as? TopPosterCollectionView else { return UITableViewCell() }
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ContentCollectionView.className, for: indexPath) as? ContentCollectionView else { return UITableViewCell() }
            return cell
        }
    }
}

extension HomeVC: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        delegate?.tableViewDidScroll(scrollView)
    }
}
