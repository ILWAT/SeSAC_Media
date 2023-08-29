//
//  ChangeUserDataView.swift
//  SeSAC_Media
//
//  Created by 문정호 on 2023/08/30.
//

import UIKit

class ChangeUserDataView: BaseView {
    let textField = {
        let view = UITextField()
        view.backgroundColor = .systemGreen
        return view
    }()

    override func setUI() {
        addSubview(textField)
    }
    
    override func setConstraints() {
        textField.snp.makeConstraints { make in
            make.horizontalEdges.top.equalTo(self.safeAreaLayoutGuide).inset(10)
        }
    }
}
