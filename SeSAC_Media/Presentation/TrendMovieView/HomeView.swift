//
//  HomeView.swift
//  SeSAC_Media
//
//  Created by 문정호 on 2023/08/28.
//

import UIKit

class HomeView: BaseView {

    lazy var collectionView = {
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 20
        let itemWitdh = UIScreen.main.bounds.width - (spacing * 2)
    
        layout.itemSize = CGSize(width: itemWitdh, height: itemWitdh) // 1:1 비율 아이템
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return view
    }()
    
    override func setUI() {
        self.addSubviews(views: [collectionView])
    }
    
    override func setConstraints() {
        collectionView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalTo(self.safeAreaLayoutGuide)
        }
    }

}
