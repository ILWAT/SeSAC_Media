//
//  URL+Extension.swift
//  SeSAC_Media
//
//  Created by 문정호 on 2023/08/11.
//

import Foundation


extension URL{
    static let tmdbBaseURL = "https://api.themoviedb.org/3"
    
    static func makeURL(endPoint: String) -> String {
        return tmdbBaseURL+endPoint
    }
}
