//
//  EndPoint.swift
//  SeSAC_Media
//
//  Created by 문정호 on 2023/08/11.
//

import Foundation

enum EndPoint{
    case trendWeek
    case credit
    case imagePath
    case genresID
    case seriesDetail
    case seasonDetail
    
    var requestURL: String{
        get{
            switch self{
            case .trendWeek:
                return URL.makeURL(type: self, endPoint: "trending/movie/week")
            case .credit:
                return URL.makeURL(type: self, endPoint: "movie/")
            case .imagePath:
                return URL.makeURL(type: self, endPoint: "")
            case .genresID:
                return URL.makeURL(type: self, endPoint: "genre/movie/list")
            case .seriesDetail:
                return URL.makeURL(type: self, endPoint: "tv/")
            case .seasonDetail:
                return URL.makeURL(type: self, endPoint: "tv/")
            }
        }
    }
}
