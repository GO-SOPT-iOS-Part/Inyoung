//
//  MyPageViewController.swift
//  SOPT_TVING
//
//  Created by 김인영 on 2023/05/01.
//

import UIKit

import SnapKit
import Then

final class MyPageViewController: UIViewController {
    
    private let naviBar = UIView()
    private lazy var backButton = UIButton().then {
        $0.setImage(ImageLiterals.Icn.back, for: .normal)
        $0.addTarget(self, action: #selector(backButtonDidTap), for: .touchUpInside)
    }
    private let alarmButton = UIButton().then {
        $0.setImage(ImageLiterals.Icn.alarm, for: .normal)
    }
    private let settingButton = UIButton().then {
        $0.setImage(ImageLiterals.Icn.setting, for: .normal)
    }
    
    private lazy var tableView = UITableView(frame: .zero, style: .grouped).then {
        $0.showsVerticalScrollIndicator = true
        $0.backgroundColor = .tvingBlack
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.allowsSelection = false
        $0.separatorStyle = .none
        $0.delegate = self
        $0.dataSource = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCells()
        setLayout()
    }
    
    @objc
    private func backButtonDidTap() {
        self.navigationController?.popViewController(animated: true)
    }
    
    private func registerCells() {
        tableView.register(MyPageTableViewCell.self, forCellReuseIdentifier: MyPageTableViewCell.className)
        tableView.register(MyPageHeaderView.self, forHeaderFooterViewReuseIdentifier: MyPageHeaderView.className)
        tableView.register(MyPageFooterView.self, forHeaderFooterViewReuseIdentifier: MyPageFooterView.className)
    }
}

extension MyPageViewController {
    
    private func setLayout() {
        view.addSubviews(naviBar, tableView)
        naviBar.addSubviews(backButton, alarmButton, settingButton)
        
        naviBar.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(45)
        }
        
        backButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(24)
            $0.size.equalTo(15)
        }
        
        settingButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(18)
            $0.size.equalTo(30)
        }
        
        alarmButton.snp.makeConstraints {
            $0.centerY.equalTo(settingButton)
            $0.trailing.equalTo(settingButton.snp.leading).offset(-9)
            $0.size.equalTo(30)
        }
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(naviBar.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
}

// MARK: - TableView Delegate & Datasource

extension MyPageViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return StringLiterals.UserSetting.array.count
        } else {
            return StringLiterals.AppSetting.array.count
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 54
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MyPageTableViewCell.className, for: indexPath) as? MyPageTableViewCell else { return UITableViewCell() }
        if indexPath.section == 0 {
            cell.dataBind(text: StringLiterals.UserSetting.array[indexPath.row])
        } else {
            cell.dataBind(text: StringLiterals.AppSetting.array[indexPath.row])
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: MyPageHeaderView.className) as? MyPageHeaderView else { return nil }
        
        let separatorView = UIView()
        separatorView.backgroundColor = .tvingGray4
        
        if section == 0 {
            return view
        } else {
            return separatorView
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 311
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        guard let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: MyPageFooterView.className) as? MyPageFooterView else { return nil }
        if section == 0 {
            view.setUI(style: .separate)
        } else {
            view.setUI(style: .logout)
        }
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 0 {
            return 32
        } else {
            return 94
        }
    }
}
