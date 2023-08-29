//
//  ExceptionTableViewCell.swift
//  SeSAC_Media
//
//  Created by 문정호 on 2023/08/30.
//

import UIKit

class ExceptionTableViewCell: BaseTableViewCell{
    let button = {
        let label = UILabel()
        label.textColor = .tintColor
        return label
    }()
    
    override func setUI() {
        contentView.addSubview(button)
    }
    
    override func setConstraints() {
        button.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(10)
            make.centerY.equalToSuperview()
        }
    }
    
    func showButtonTitle(_ title: String){
        button.text = title
    }
    
}
