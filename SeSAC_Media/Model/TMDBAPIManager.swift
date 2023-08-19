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
    
    var genreData: GenresData = GenresData(genres: [])
    
    private init(){ callGenresIDRequest(endPoint: .genresID) }
    
    func callTrendMovieRequest(endPoint: EndPoint, saveData: @escaping (TrendMovieData) -> Void){
        let url = endPoint.requestURL
        
        AF.request(url, method: .get, headers: header).validate().responseDecodable(of: TrendMovieData.self) { response in
            switch response.result{
            case .success(let value):
                saveData(value)
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func callTVEpisodeRequest(endPoint: EndPoint, series_id: Int,  saveData: @escaping (TVSeriesData) -> ()) {
        let url = endPoint.requestURL+"?language=ko-KR"
        
        AF.request(url, method: .get, headers: header).validate().responseDecodable(of: TVSeriesData.self) { response in
            switch response.result{
            case .success(let value):
                saveData(value)
            case .failure(let error):
                print(error)
            }
        }
        
    }
    
    func returnImagePathURL(endPoint: EndPoint, imagePath: String) -> String{
        let url = endPoint.requestURL + imagePath
        
       return url
    }
    
    func callGenresIDRequest(endPoint: EndPoint){
        let url = endPoint.requestURL
        
        AF.request(url, method: .get, headers: header).validate().responseDecodable(of: GenresData.self) { response in
            switch response.result{
            case .success(let value):
                self.genreData = value
            case .failure(let error):
                print(error)
            }
        }
        
//        AF.request(url, method: .get, headers: header).validate().responseJSON{ response in
//            switch response.result{
//            case .success(let value):
//                let json = JSON(value)
//
//                for item in json["genres"].arrayValue{
//                    self.genreData.append(GenresData(name: item["name"].stringValue, id: item["id"].intValue))
//                }
//            case .failure(let error):
//                print(error)
//            }
//
//        }
    }
    
    func checkGenre(genreID: [Int]) -> String {
        var returnString: String = ""
        
        for item in genreData.genres{
            if genreID.contains(item.id){
                returnString = returnString + "#\(item.name) "
            }
        }
        return returnString
    }
    
    func callCreditRequest(endPoint: EndPoint, movieID: Int, completionHandler: @escaping ([Cast]) -> Void){
        let url = endPoint.requestURL + "\(movieID)" + "/credits"
        
        AF.request(url, method: .get, headers: header).validate().responseDecodable(of: CreditsData.self) { response in
            switch response.result{
            case .success(let value):
                completionHandler(value.cast)
            case .failure(let error):
                print(error)
            }
        }
        
//        AF.request(url, method: .get, headers: header).validate().responseJSON { response in
//            switch response.result{
//            case .success(let value):
//                let json = JSON(value)
//
//                var castingData: [PeopleData] = []
//
//                for item in json["cast"].arrayValue{
//                    let adults = item["adult"].boolValue
//                    let gender = item["gender"].intValue
//                    let name = item["name"].stringValue
//                    let known_for_department = json["known_for_department"].stringValue
//                    let original_name = item["original_name"].stringValue
//                    let profile_path = item["profile_path"].stringValue
//                    let popularity = item["popularity"].doubleValue
//                    let cast_id = item["cast_id"].intValue
//                    let character = item["character"].stringValue
//                    let credit_id = item["credit_id"].stringValue
//                    let order = item["order"].intValue
//
//                    castingData.append(PeopleData(adult: adults, gender: gender, department: known_for_department, name: name, originalName: original_name, popularity: popularity, profile: profile_path, cast_id: cast_id, character: character, creditID: credit_id, order: order))
//                }
//
//                saveData(castingData)
//
//            case .failure(let error):
//                print(error, #function)
//            }
//
//        }
    }
}
