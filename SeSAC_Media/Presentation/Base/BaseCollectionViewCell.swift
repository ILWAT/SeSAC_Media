//
//  BaseCollectionViewCell.swift
//  SeSAC_Media
//
//  Created by 문정호 on 2023/08/28.
//

import UIKit

class BaseCollectionViewCell: UICollectionViewCell{
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUI() {}
    
    func showData<T: Codable>(data :T){}
    
    func setConstraints(){}
}
