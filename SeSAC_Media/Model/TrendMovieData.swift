//
//  TrendMovieData.swift
//  SeSAC_Media
//
//  Created by 문정호 on 2023/08/11.
//

import Foundation
import SwiftyJSON

struct TrendMovieData{
    let adult: Bool
    let backdrop_path: String
    let id: Int
    let title: String
    let original_language: String
    let original_title: String
    let overview: String
    let poster_path:String
    let media_type:String
    let genre_ids: [JSON]
    let popularity: Double
    let video: Bool
    let release_date: String
    let vote_average: Double
    let vote_count: Int
}