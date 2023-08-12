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
    
    
    var requestURL: String{
        switch self{
        case .trendWeek:
            return URL.makeURL(endPoint: "3/trending/movie/week")
        case .credit:
            return URL.makeURL(endPoint: "movie/{movie_id}/credits")
        }
    }
}
