//
//  BaseViewController.swift
//  SeSAC_Media
//
//  Created by 문정호 on 2023/08/28.
//

import UIKit

class BaseViewController: UIViewController {
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        setNavigation()
    }
    
    ///AddTarget, Register등을 수행하는 메서드
    func configure() {}
    
    
    ///Navigation을 설정하는 메서드
    func setNavigation(){}


}
