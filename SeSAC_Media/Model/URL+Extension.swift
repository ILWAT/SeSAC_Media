//
//  URL+Extension.swift
//  SeSAC_Media
//
//  Created by 문정호 on 2023/08/11.
//

import Foundation


extension URL{
    static let tmdbBaseURL = "https://api.themoviedb.org/3/"
    static let imageBaseURL = "https://image.tmdb.org/t/p/original"
    
    static func makeURL(type: EndPoint, endPoint: String) -> String {
        if type == EndPoint.imagePath{
            return imageBaseURL+endPoint
        } else {
            return tmdbBaseURL+endPoint
        }
        
    }
}
