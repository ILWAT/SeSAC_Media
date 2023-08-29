//
//  ProfileImageTableViewCell.swift
//  SeSAC_Media
//
//  Created by 문정호 on 2023/08/29.
//

import UIKit
import SnapKit

class ProfileImageTableViewCell: BaseTableViewCell {
    //MARK: - Properties
    lazy var profileImage = {
        let image = UIImageView()
        image.image = UIImage(systemName: "person.fill")
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        DispatchQueue.main.async {
            self.layer.cornerRadius = self.frame.width/2
        }
        return image
    }()
    
    lazy var avatarImage = {
        let image = UIImageView()
        image.image = UIImage(systemName: "person.fill")
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        DispatchQueue.main.async {
            self.layer.cornerRadius = self.frame.width/2
        }
        return image
    }()
    
    let imageStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.spacing = 10
        view.alignment = .fill
        view.distribution = .fillEqually
        return view
    }()
    
    let modifyButton = {
        let button = UIButton()
        button.setTitle("사진 또는 아바타 수정", for: .normal)
        button.setTitleColor(UIColor.tintColor, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14)
        return button
    }()
    
    //MARK: - awakeFromNib
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func setUI() {
        contentView.addSubviews(views: [imageStackView, modifyButton])
        imageStackView.addArrangedSubview(profileImage)
        imageStackView.addArrangedSubview(avatarImage)
    }
    
    override func setConstraints() {
        imageStackView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-10)
            make.height.equalToSuperview().multipliedBy(0.5)
            make.width.equalTo(imageStackView.snp.height).multipliedBy(2)
        }
        modifyButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(imageStackView.snp.bottom)
        }
    }
    
    
    
    

}
