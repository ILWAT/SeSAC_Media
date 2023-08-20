//
//  AssociatedCollectionViewCell.swift
//  SeSAC_Media
//
//  Created by 문정호 on 2023/08/21.
//

import UIKit
import Kingfisher

class AssociatedCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var associatedImageView: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setUI(segmented: Int, videoData: VideoResult? = nil, similarData: TVSimilarResult? = nil){
        if segmented == 0{
            guard let similarData else {return}
            setUIData(similarData: similarData)
        } else if segmented == 1{
            guard let videoData else { return }
            setUIData(videoData: videoData)
        }
    }
    
    private func setUIData(similarData: TVSimilarResult){
        titleLabel.text = similarData.name
        
        descriptionLabel.text = similarData.overview
        
        associatedImageView.kf.setImage(with: URL(string: EndPoint.imagePath.requestURL + (similarData.posterPath ?? "")))
        
    }
    
    private func setUIData(videoData: VideoResult){
        titleLabel.text = videoData.name
        
        descriptionLabel.text = videoData.site
        
        associatedImageView.image = nil
    }

}
