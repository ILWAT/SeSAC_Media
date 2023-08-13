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
    
    
    var requestURL: String{
        switch self{
        case .trendWeek:
            return URL.makeURL(type: self, endPoint: "/3/trending/movie/week")
        case .credit:
            return URL.makeURL(type: self, endPoint: "/movie/{movie_id}/credits")
        case .imagePath:
            return URL.makeURL(type: self, endPoint: "")
        case .genresID:
            return URL.makeURL(type: self, endPoint: "/3/genre/movie/list")
        }
    }
}
