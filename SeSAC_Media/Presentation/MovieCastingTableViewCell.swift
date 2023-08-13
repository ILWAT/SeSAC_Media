//
//  MovieCastingTableViewCell.swift
//  SeSAC_Media
//
//  Created by 문정호 on 2023/08/14.
//

import UIKit

class MovieCastingTableViewCell: UITableViewCell {

    @IBOutlet weak var castingDescriptionLabel: UILabel!
    @IBOutlet weak var castingNameLabel: UILabel!
    @IBOutlet weak var castingImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setUI(data: PeopleData){
        castingImageView.layer.cornerRadius = 5
        setData(data)
    }
    
    func setData(_ data: PeopleData){
        castingNameLabel.text = data.name
        
        castingDescriptionLabel.text = data.character
        
        castingImageView.kf.setImage(with: URL(string: TMDBAPIManager.shared.callImageRequest(endPoint: .imagePath, imagePath: data.profile)))
    }
    
}
