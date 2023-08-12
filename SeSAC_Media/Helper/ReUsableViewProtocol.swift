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

extension UICollectionViewCell: ReUsableViewProtocol {
    static var identifier: String {
        return String(describing: self)
    }
}
