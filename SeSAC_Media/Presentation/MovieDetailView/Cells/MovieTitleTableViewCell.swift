//
//  MovieTitleTableViewCell.swift
//  SeSAC_Media
//
//  Created by 문정호 on 2023/08/14.
//

import UIKit
import Kingfisher

class MovieTitleTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var mainImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setUI(data: Result){
        titleLabel.text = data.title
        titleLabel.font = .boldSystemFont(ofSize: 17)
        titleLabel.textColor = .white
        
        mainImageView.kf.setImage(with: URL(string: EndPoint.imagePath.requestURL+data.posterPath))
        
        backgroundImageView.kf.setImage(with: URL(string: EndPoint.imagePath.requestURL+data.backdropPath))
        backgroundImageView.contentMode = .scaleAspectFill
    }
    
}
