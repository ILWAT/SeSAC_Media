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
    
    func callTrendMovieRequest(endPoint: EndPoint, saveData: @escaping ([TrendMovieData]) -> Void){
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
//    "adult": false,
//                "gender": 2,
//                "id": 587506,
//                "known_for_department": "Acting",
//                "name": "Shameik Moore",
//                "original_name": "Shameik Moore",
//                "popularity": 40.911,
//                "profile_path": "/uJNaSTsfBOvtFWsPP23zNthknsB.jpg",
//                "cast_id": 705,
//                "character": "Miles Morales / Spider-Man (voice)",
//                "credit_id": "6489a4f8e375c000e251ab48",
//                "order": 0
    
    func callCreditRequest(endPoint: EndPoint, movieID: Int, saveData: @escaping ([PeopleData]) -> Void){
        let url = endPoint.requestURL + "\(movieID)" + "/credits"
        
        AF.request(url, method: .get, headers: header).validate().responseJSON { response in
            switch response.result{
            case .success(let value):
                let json = JSON(value)
                
                var castingData: [PeopleData] = []
                
                for item in json["cast"].arrayValue{
                    let adults = item["adult"].boolValue
                    let gender = item["gender"].intValue
                    let name = item["name"].stringValue
                    let known_for_department = json["known_for_department"].stringValue
                    let original_name = item["original_name"].stringValue
                    let profile_path = item["profile_path"].stringValue
                    let popularity = item["popularity"].doubleValue
                    let cast_id = item["cast_id"].intValue
                    let character = item["character"].stringValue
                    let credit_id = item["credit_id"].stringValue
                    let order = item["order"].intValue
                    
                    castingData.append(PeopleData(adult: adults, gender: gender, department: known_for_department, name: name, originalName: original_name, popularity: popularity, profile: profile_path, cast_id: cast_id, character: character, creditID: credit_id, order: order))
                }
                
                saveData(castingData)
                
            case .failure(let error):
                print(error, #function)
            }
            
        }
    }
}
