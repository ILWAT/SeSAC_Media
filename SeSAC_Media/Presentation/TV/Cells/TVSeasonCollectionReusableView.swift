//
//  TVSeasonCollectionReusableView.swift
//  SeSAC_Media
//
//  Created by 문정호 on 2023/08/19.
//

import UIKit

class TVSeasonCollectionReusableView: UICollectionReusableView {

    @IBOutlet weak var EpisodeCountLabel: UILabel!
    @IBOutlet weak var TitleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setUI(data: TVSeriesData, season: Int) {
        
        setUIData(data: data,season: season)
    }
    
    private func setUIData(data: TVSeriesData, season: Int) {
        TitleLabel.text = data.seasons[season].name
        
        EpisodeCountLabel.text = "\(data.seasons[season].episodeCount)화"
        
        descriptionLabel.text = data.seasons[season].overview
        
    }
    
}
