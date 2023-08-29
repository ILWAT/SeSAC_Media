//
//  ProfileView.swift
//  SeSAC_Media
//
//  Created by 문정호 on 2023/08/29.
//

import UIKit

class ProfileView: BaseView {
    //MARK: - Properties
    let tableView = UITableView()
    
    //MARK: - SetUI
    override func setUI() {
        addSubviews(views: [tableView])
    }
    
    override func setConstraints() {
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(self.safeAreaLayoutGuide)
        }
    }
}
