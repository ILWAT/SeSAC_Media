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
    func setUI(data: Result){
        DispatchQueue.main.async{
            self.clipButton.layer.cornerRadius = self.clipButton.frame.width/2
        }
        clipButton.layer.borderWidth = 1
        clipButton.layer.borderColor = UIColor.black.cgColor
        
        cellBackgroundView.layer.cornerRadius = 5
        cellBackgroundView.layer.shadowColor = UIColor.gray.cgColor
        cellBackgroundView.layer.shadowOffset = CGSize(width: 10, height: 10)
        cellBackgroundView.layer.shadowOpacity = 10
        
        detailLabel.text = "자세히 보기"
        
        genreLabel.font = .boldSystemFont(ofSize: 17)
        
        setData(data: data)
    }
    
    func setData(data: Result){
        movieTitleLabel.text = data.title
        movieTitleLabel.font = .boldSystemFont(ofSize: 17)
        
        rateLabel.text = "\(data.voteAverage)"
        
        dateLabel.text = data.releaseDate
        
        movieImageView.kf.setImage(with: URL(string: TMDBAPIManager.shared.returnImagePathURL(endPoint: .imagePath, imagePath: data.backdropPath)))
        movieImageView.contentMode = .scaleAspectFit
        
        genreLabel.text = TMDBAPIManager.shared.checkGenre(genreID: data.genreIDS)
    }

}
