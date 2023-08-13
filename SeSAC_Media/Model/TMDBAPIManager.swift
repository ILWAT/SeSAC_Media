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
    
    let header: HTTPHeaders = ["Authorization": APIKeys.tmdbAccessToken, "accept": "application/json"]
    
    var genreData: [GenresData] = []
    
    private init(){ callGenresID(endPoint: .genresID) }
    
    func callRequest(endPoint: EndPoint, saveData: @escaping ([TrendMovieData]) -> Void){
        let url = endPoint.requestURL
        
        AF.request(url, method: .get, headers: header).validate().responseJSON { response in
            switch response.result{
            case .success(let value):
                let json = JSON(value)
                
                var movieData: [TrendMovieData] = []
                
                let dataPath = json["results"]
                
                for item in dataPath.arrayValue{
                    
                    let adult = item["adult"].boolValue
                    let backdrop_path = item["backdrop_path"].stringValue
                    let id: Int = item["id"].intValue
                    let title: String = item["title"].stringValue
                    let original_language: String = item["original_language"].stringValue
                    let original_title: String = item["original_title"].stringValue
                    let overview: String = item["overview"].stringValue
                    let poster_path:String = item["poster_path"].stringValue
                    let media_type:String = item["media_type"].stringValue
                    let genre_ids: [JSON] = item["genre_ids"].arrayValue
                    let popularity: Double = item["popularity"].doubleValue
                    let release_date: String = item["release_date"].stringValue
                    let video: Bool = item["video"].boolValue
                    let vote_average: Double = item["vote_average"].doubleValue
                    let vote_count: Int = item["vote_count"].intValue
                    
                    
                    movieData.append(TrendMovieData(adult: adult, backdrop_path: backdrop_path, id: id, title: title, original_language: original_language, original_title: original_title, overview: overview, poster_path: poster_path, media_type: media_type, genre_ids: genre_ids, popularity: popularity, video: video, release_date: release_date, vote_average: vote_average, vote_count: vote_count))
                    
                    
                }
                print(movieData)
                
                saveData(movieData)
                
                
            case .failure(let error):
                print(error)
            }
            
        }
    }
    
    func callImageRequest(endPoint: EndPoint, imagePath: String) -> String{
        let url = endPoint.requestURL + imagePath
        
       return url
    }
    
    func callGenresID(endPoint: EndPoint){
        let url = endPoint.requestURL
        
        AF.request(url, method: .get, headers: header).validate().responseJSON{ response in
            switch response.result{
            case .success(let value):
                let json = JSON(value)
                
                for item in json["genres"].arrayValue{
                    self.genreData.append(GenresData(name: item["name"].stringValue, id: item["id"].intValue))
                }
            case .failure(let error):
                print(error)
            }
            
        }
    }
    
    func checkGenre(genreID: [JSON]) -> String {
        var returnString: String = ""
        var receivedGenreID: [Int] = []
        
        for item in genreID{
            receivedGenreID.append(item.intValue)
        }
        
        for item in genreData{
            if receivedGenreID.contains(item.id){
                returnString = returnString + "#\(item.name) "
            }
        }
        return returnString
    }
    
}
