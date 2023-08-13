//
//  TrendMovieCollectionViewCell.swift
//  SeSAC_Media
//
//  Created by 문정호 on 2023/08/11.
//

import UIKit
import Kingfisher

class TrendMovieCollectionViewCell: UICollectionViewCell {

    //MARK: - Properties
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var rateLabel: UILabel!
    @IBOutlet weak var clipButton: UIButton!
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var cellBackgroundView: UIView!
    @IBOutlet weak var dateLabel: UILabel!
    
    //MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    //MARK: - setUI()
    func setUI(data: TrendMovieData){
        DispatchQueue.main.async{
            self.clipButton.layer.cornerRadius = self.clipButton.frame.width/2
        }
        cellBackgroundView.layer.cornerRadius = 5
        cellBackgroundView.layer.shadowColor = UIColor.gray.cgColor
        cellBackgroundView.layer.shadowOffset = CGSize(width: 10, height: 10)
        cellBackgroundView.layer.shadowOpacity = 10
        
        detailLabel.text = "자세히 보기"
        
        setData(data: data)
    }
    
    func setData(data: TrendMovieData){
        movieTitleLabel.text = data.title
        movieTitleLabel.font = .boldSystemFont(ofSize: 17
        )
        
        rateLabel.text = "\(data.vote_average)"
        
        dateLabel.text = data.release_date
        
        movieImageView.kf.setImage(with: URL(string: TMDBAPIManager.shared.callImageRequest(endPoint: .imagePath, imagePath: data.poster_path)))
        movieImageView.contentMode = .scaleAspectFit
        
        genreLabel.text = TMDBAPIManager.shared.checkGenre(genreID: data.genre_ids)
    }

}
