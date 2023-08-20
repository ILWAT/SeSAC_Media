//
//  TVEpisodeCollectionViewCell.swift
//  SeSAC_Media
//
//  Created by 문정호 on 2023/08/19.
//

import UIKit
import Kingfisher

class TVEpisodeCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var episodeDescriptionLabel: UILabel!
    @IBOutlet weak var episodeRunningTimeLabel: UILabel!
    @IBOutlet weak var episodeTitleLabel: UILabel!
    @IBOutlet weak var episodeImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setUI(tvEpisode: Episode) {
        episodeImageView.layer.cornerRadius = 5
        setUIData(tvEpisode: tvEpisode)
    }
    
    private func setUIData(tvEpisode: Episode) {
        episodeImageView.kf.setImage(with: URL(string: EndPoint.imagePath.requestURL + tvEpisode.stillPath))
        episodeImageView.contentMode = .scaleAspectFill
        
        episodeTitleLabel.text = tvEpisode.name
        episodeTitleLabel.font = .boldSystemFont(ofSize: 17)
        
        episodeRunningTimeLabel.text = "\(tvEpisode.runtime)분"
        episodeRunningTimeLabel.textColor = .systemGray
        
        episodeDescriptionLabel.text = tvEpisode.overview
    }
}
