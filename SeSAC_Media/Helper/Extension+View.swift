//
//  Extension+View.swift
//  SeSAC_Media
//
//  Created by 문정호 on 2023/08/27.
//

import UIKit

extension UIView{
    
    func addSubviews(views: [UIView]){
        views.forEach { view in
            self.addSubview(view)
        }
    }
    
}
