//
//  TMDBAPIManager.swift
//  SeSAC_Media
//
//  Created by 문정호 on 2023/08/11.
//

import Foundation
import Alamofire
import SwiftyJSON

class TMDBAPIManager{
    static let shared = TMDBAPIManager()
    
    private init(){}
    
    func callRequest(endPoint: EndPoint, saveData: @escaping ([TrendMovieData]) -> Void){
        let url = EndPoint.trendWeek.requestURL
        
        let header: HTTPHeaders = ["Authorization": APIKeys.tmdbAccessToken]
        
        AF.request(url, method: .get, headers: header).validate().responseJSON { response in
            switch response.result{
            case .success(let value):
                let json = JSON(value)
                
                var movieData: [TrendMovieData] = []
                
                let dataPath = json["result"]
                
                for item in dataPath.arrayValue{
                    
                    let adult = dataPath["adult"].boolValue
                    let backdrop_path = dataPath["backdrop_path"].stringValue
                    let id: Int = dataPath["id"].intValue
                    let title: String = dataPath["title"].stringValue
                    let original_language: String = dataPath["original_language"].stringValue
                    let original_title: String = dataPath["original_title"].stringValue
                    let overview: String = dataPath["overview"].stringValue
                    let poster_path:String = dataPath["poster_path"].stringValue
                    let media_type:String = dataPath["media_type"].stringValue
                    let genre_ids: [JSON] = dataPath["genre_ids"].arrayValue
                    let popularity: Double = dataPath["popularity"].doubleValue
                    let release_date: String = dataPath["release_date"].stringValue
                    let video: Bool = dataPath["video"].boolValue
                    let vote_average: Double = dataPath["vote_average"].doubleValue
                    let vote_count: Int = dataPath["vote_count"].intValue
                    
                    
                    movieData.append(TrendMovieData(adult: adult, backdrop_path: backdrop_path, id: id, title: title, original_language: original_language, original_title: original_title, overview: overview, poster_path: poster_path, media_type: media_type, genre_ids: genre_ids, popularity: popularity, video: video, release_date: release_date, vote_average: vote_average, vote_count: vote_count))
                    
                    print(movieData)
                }
                
                saveData(movieData)
                
            case .failure(let error):
                print(error)
            }
            
        }
    }
}
