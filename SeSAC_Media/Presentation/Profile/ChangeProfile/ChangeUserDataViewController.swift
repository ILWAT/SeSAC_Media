//
//  ChangeUserDataViewController.swift
//  SeSAC_Media
//
//  Created by 문정호 on 2023/08/30.
//

import UIKit

//protocol-delegate를 통한 값 전달 1
protocol PassChangeValue{
    func sendValue(value: String, changedCategory: Int)
}

class ChangeUserDataViewController: BaseViewController {
    let mainView = ChangeUserDataView()
    var titleText: String = ""
    var index: Int = 0
    
    //protocol-delegate를 통한 값 전달 2
//    var delegate:PassChangeValue?
    
    //Closure를 통한 값 전달 1
//    var valuePassClosure: ((String, Int)->())?
    
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
            //protocol-delegate를 통한 값 전달 4
//            delegate?.sendValue(value: inputText, changedCategory: index)
            
            //Closure를 통한 값 전달
//            valuePassClosure?(inputText, index)
            
            //Notification을 통한 값 전달
            NotificationCenter.default.post(name: NSNotification.Name("SettingValueChanger"), object: nil, userInfo: ["changedValueInChangeVC": inputText, "index" : index])
        }
        
        self.navigationController?.popViewController(animated: true)
    }
    

}
