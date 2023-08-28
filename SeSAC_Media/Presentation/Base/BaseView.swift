//
//  BaseViewController.swift
//  SeSAC_Media
//
//  Created by 문정호 on 2023/08/28.
//

import UIKit
import SnapKit

class BaseView: UIView {
    
    ///View의 선언부
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        setUI()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    ///AddSubView를 수행하는 메서드
    func setUI(){ }
    
    ///View의 UI 배치를 수행하는 메서드
    func setConstraints(){ }

}
