//
//  ReUsableViewProtocol.swift
//  SeSAC_Media
//
//  Created by 문정호 on 2023/08/11.
//

import Foundation
import UIKit

protocol ReUsableViewProtocol{
    static var identifier: String { get }
}

extension UICollectionReusableView: ReUsableViewProtocol{
    static var identifier: String {
        return String(describing: self)
    }
}

extension UIViewController: ReUsableViewProtocol{
    static var identifier: String{
        return String(describing: self)
    }
}

extension UITableViewCell: ReUsableViewProtocol{
    static var identifier: String{
        return String(describing: self)
    }
}


