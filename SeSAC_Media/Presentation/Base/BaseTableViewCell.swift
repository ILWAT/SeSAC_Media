//
//  BaseTableViewCell.swift
//  SeSAC_Media
//
//  Created by 문정호 on 2023/08/29.
//

import UIKit

class BaseTableViewCell: UITableViewCell{
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.backgroundColor = .white
        setUI()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    ///addSubView를 수행
    func setUI(){}
    
    ///UI 제약조건 설정
    func setConstraints(){}
}
