//
//  ProfileViewController.swift
//  SeSAC_Media
//
//  Created by 문정호 on 2023/08/29.
//

import UIKit

class ProfileViewController: BaseViewController{
    //MARK: - Properties
    let mainView = ProfileView()
    
    var userData:UserData = UserData(){
        didSet{
            mainView.tableView.reloadData()
        }
    }
    
    let settingTitle = ["사진 또는 아바타 수정","이름", "사용자 이름", "성별 대명사", "소개", "링크", "성별", "프로페셔널 계정으로 전환", "개인정보 설정"]
    
    //MARK: - LifeCycle
    override func loadView() {
        view = mainView
    }
    
    override func configure() {
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
        mainView.tableView.register(ProfileImageTableViewCell.self, forCellReuseIdentifier: ProfileImageTableViewCell.identifier)
        mainView.tableView.register(ProfileDefaultTableViewCell.self, forCellReuseIdentifier: ProfileDefaultTableViewCell.identifier)
        mainView.tableView.register(ExceptionTableViewCell.self, forCellReuseIdentifier: ExceptionTableViewCell.identifier)
    }
    
    override func setNavigation() {
        self.title = "프로필 편집"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "완료", style: .plain, target: self, action: #selector(tappedCompleteButton))
    }
    
    
    @objc func tappedCompleteButton(_ sender: UIBarButtonItem){
        self.navigationController?.popViewController(animated: true)
    }
}

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingTitle.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row{
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ProfileImageTableViewCell.identifier, for: indexPath) as? ProfileImageTableViewCell else {return UITableViewCell()}
            return cell
        case  7, 8:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ExceptionTableViewCell.identifier, for: indexPath) as? ExceptionTableViewCell else {return UITableViewCell()}
            cell.showButtonTitle(settingTitle[indexPath.row])
            
            return cell
            
        default:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ProfileDefaultTableViewCell.identifier, for: indexPath) as? ProfileDefaultTableViewCell else {return UITableViewCell()}
            
            cell.showText(text: settingTitle[indexPath.row], secondaryText: userData.valueReturn(dataType: indexPath.row))
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row{
        case 0:
            return 150
        default:
            return 50
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row{
        case 0:
            print("아바타 또는 사진 수정")
        case  7, 8:
            print("추가 화면 필요")
        default:
            print("화면 전환")
            let nextVC = ChangeUserDataViewController()
            nextVC.titleText = settingTitle[indexPath.row]
            nextVC.setPlaceHoler(currentValue: userData.valueReturn(dataType: indexPath.row))
            nextVC.index = indexPath.row
            nextVC.delegate = self
            self.navigationController?.pushViewController(nextVC, animated: true)
        }
    }
}


extension ProfileViewController: PassChangeValue{
    func sendValue(value: String, changedCategory: Int) {
        self.userData.chageValue(dataType: changedCategory, newValue: value)
    }
}
