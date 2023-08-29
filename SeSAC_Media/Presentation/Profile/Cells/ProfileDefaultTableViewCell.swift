//
//  ProfileDefaultTableViewCell.swift
//  SeSAC_Media
//
//  Created by 문정호 on 2023/08/29.
//

import UIKit

class ProfileDefaultTableViewCell: BaseTableViewCell {
    //MARK: - Properties
    var title: UILabel = UILabel()
    var subTitle: UILabel = {
        let label = UILabel()
        label.textColor = .systemGray
        return label
    }()
    
    let indicator: UIImageView = {
        let image = UIImageView(image: UIImage(systemName: "chevron.right"))
        image.tintColor = .systemGray
        return image
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func setUI() {
        addSubviews(views: [title, subTitle, indicator])
    }

    override func setConstraints() {
        title.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().inset(10)
        }
        subTitle.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(title.snp.trailing).offset(10)
        }
        indicator.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(10)
            make.centerY.equalToSuperview()
        }
        
    }
    
    func showText(text: String, secondaryText: String){
        title.text = text
        subTitle.text = secondaryText
    }
    
}
