//
//  TrendMovieCollectionViewCell.swift
//  SeSAC_Media
//
//  Created by 문정호 on 2023/08/11.
//

import UIKit
import Kingfisher

class TrendMovieCollectionViewCell: BaseCollectionViewCell {

    //MARK: - Properties
    
    let originalTitleLabel: UILabel = UILabel()
    let descriptionLabel: UILabel = UILabel()
    let movieTitleLabel: UILabel = UILabel()
    let genreLabel: UILabel = UILabel()
    let dateLabel: UILabel = UILabel()
    
    let rateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.backgroundColor = .white
        return label
    }()
    
    let detailLabel: UILabel = {
        let label = UILabel()
        label.text = "자세히 보기"
        return label
    }()
    
    let rateTextLabel: UILabel = {
        let label = UILabel()
        label.text = "평점"
        label.backgroundColor = .tintColor
        label.textColor = .white
        return label
    }()
    
    let movieImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    let cellBackgroundView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 5
        view.layer.shadowColor = UIColor.gray.cgColor
        view.layer.shadowOffset = CGSize(width: 10, height: 10)
        view.layer.shadowOpacity = 10
        view.backgroundColor = .white
        return view
    }()
    
    let separateView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray
        return view
    }()
    
    
    lazy var rateStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.spacing = 0
        view.alignment = .fill
        view.distribution = .fillEqually
        return view
    }()
    
    lazy var clipButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "paperclip"), for: .normal)
        button.backgroundColor = .white
        DispatchQueue.main.async{
            self.clipButton.layer.cornerRadius = self.clipButton.frame.width/2
        }
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.black.cgColor
        return button
    }()
    
    //MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    //MARK: - setUI()
    override func setUI(){
        
        for item in [originalTitleLabel, movieTitleLabel, descriptionLabel, rateLabel, dateLabel]{
            item.textColor = .black
            item.font = .systemFont(ofSize: 17)
        }
        
        contentView.addSubviews(views: [genreLabel, dateLabel, cellBackgroundView])
        cellBackgroundView.addSubviews(views: [movieImageView, originalTitleLabel, movieTitleLabel, descriptionLabel, detailLabel,separateView])
        movieImageView.addSubviews(views: [clipButton, rateStackView])
        
        movieTitleLabel.font = .boldSystemFont(ofSize: 17)
        genreLabel.font = .boldSystemFont(ofSize: 17)
        genreLabel.font = .boldSystemFont(ofSize: 17)
        
    }
        
    
    override func showData<T>(data: T) where T : Decodable, T : Encodable {
        guard let data = data as? Result else { return }
        
        movieTitleLabel.text = data.title
        
        originalTitleLabel.text = data.originalTitle
        
        rateLabel.text = "\(data.voteAverage)"
        
        dateLabel.text = data.releaseDate
        
        movieImageView.kf.setImage(with: URL(string: TMDBAPIManager.shared.returnImagePathURL(endPoint: .imagePath, imagePath: data.backdropPath)))
        movieImageView.contentMode = .scaleAspectFit
        
        genreLabel.text = TMDBAPIManager.shared.checkGenre(genreID: data.genreIDS)
    }
    
    override func setConstraints() {
        dateLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(10)
            make.trailing.greaterThanOrEqualToSuperview().inset(10)
            make.leading.equalToSuperview().inset(10)
        }
        genreLabel.snp.makeConstraints { make in
            make.leading.equalTo(dateLabel)
            make.top.equalTo(dateLabel.snp.bottom).offset(10)
            make.trailing.lessThanOrEqualToSuperview().inset(10)
        }
        cellBackgroundView.snp.makeConstraints { make in
            make.top.equalTo(genreLabel.snp.bottom).offset(5)
            make.leading.equalTo(dateLabel)
            make.trailing.equalToSuperview().inset(10)
            make.bottom.equalToSuperview().inset(20)
        }
        
        
        movieImageView.snp.makeConstraints { make in
            make.trailing.leading.top.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.7)
        }
        rateStackView.snp.makeConstraints { make in
            make.leading.bottom.equalToSuperview().inset(15)
            make.width.equalToSuperview().multipliedBy(0.25)
            make.height.equalTo(rateStackView.snp.width).multipliedBy(0.5)
        }
        clipButton.snp.makeConstraints { make in
            make.top.trailing.equalToSuperview().inset(5)
            make.height.equalToSuperview().multipliedBy(0.2)
            make.width.equalTo(clipButton.snp.height)
        }
        movieTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(movieImageView.snp.bottom).offset(10)
            make.leading.equalToSuperview().inset(10)
            make.trailing.equalTo(originalTitleLabel.snp.leading)
        }
        originalTitleLabel.snp.makeConstraints { make in
            make.centerY.equalTo(movieTitleLabel)
            make.leading.equalTo(movieTitleLabel.snp.trailing).offset(10)
            make.trailing.equalToSuperview().inset(10)
        }
        descriptionLabel.snp.makeConstraints { make in
            make.leading.equalTo(movieTitleLabel)
            make.trailing.greaterThanOrEqualToSuperview().inset(10)
            make.top.equalTo(movieTitleLabel.snp.bottom)
        }
        separateView.snp.makeConstraints { make in
            make.leading.equalTo(movieTitleLabel)
            make.trailing.equalToSuperview().inset(10)
            make.top.equalTo(descriptionLabel.snp.bottom).offset(5)
            make.height.equalTo(1)
        }
        detailLabel.snp.makeConstraints { make in
            make.leading.equalTo(movieTitleLabel)
            make.bottom.equalToSuperview()
            make.top.lessThanOrEqualTo(separateView.snp.bottom)
            
        }
    }

}
