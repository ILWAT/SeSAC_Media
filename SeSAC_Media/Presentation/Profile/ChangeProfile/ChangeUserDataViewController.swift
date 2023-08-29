//
//  ChangeUserDataViewController.swift
//  SeSAC_Media
//
//  Created by 문정호 on 2023/08/30.
//

import UIKit

protocol PassChangeValue{
    func sendValue(value: String, changedCategory: Int)
}

class ChangeUserDataViewController: BaseViewController {
    let mainView = ChangeUserDataView()
    var titleText: String = ""
    var index: Int = 0
    
    var delegate:PassChangeValue?
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func setNavigation() {
        self.title = titleText
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "완료", style: .plain, target: self, action: #selector(tappedCompleteButton))
    }
    
    
    func setPlaceHoler(currentValue: String){
        mainView.textField.placeholder = currentValue
    }
    
    @objc func tappedCompleteButton(_ sender: UIBarButtonItem){
        if let inputText = mainView.textField.text{
            delegate?.sendValue(value: inputText, changedCategory: index)
        }
        self.navigationController?.popViewController(animated: true)
    }
    

}
