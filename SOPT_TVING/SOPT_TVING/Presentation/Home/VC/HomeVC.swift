//
//  HomeTabViewController.swift
//  SOPT_TVING
//
//  Created by 김인영 on 2023/05/03.
//

import UIKit

import SnapKit
import Then

import Alamofire

protocol HomeVCProtocol: AnyObject {
    func tableViewDidScroll(_ scrollView: UIScrollView)
}

class HomeVC: UIViewController {
    
    // MARK: - Properties
    
    weak var delegate: HomeVCProtocol?
    private var movieArray: [MovieListModel] = []
    
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
        getMovie()
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
            if indexPath.row == 1 {
                cell.setData(data: self.movieArray)
            }
            return cell
        }
    }
}

extension HomeVC: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        delegate?.tableViewDidScroll(scrollView)
    }
}

// MARK: - Nerwork

extension HomeVC {
    func getMovie() {
        MovieRequest.shared.getNowPlayingMovie { response in
            switch response {
            case .success(let data):
                guard let data = data as? MovieResponse else { return }
                let results = data.results
                
                // MovieListModel 배열로 변환
                self.movieArray = results.map { movie in
                    MovieListModel(title: movie.title, imageURL: movie.posterPath)
                }
                self.tableView.reloadData()
            default:
                print("failed")
                return
            }
        }
    }
}
