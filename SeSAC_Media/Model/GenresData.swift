//
//  GenresData.swift
//  SeSAC_Media
//
//  Created by 문정호 on 2023/08/13.
//

import Foundation

// MARK: - GenresData
struct GenresData: Codable {
    let genres: [Genre]
}

// MARK: - Genre
struct Genre: Codable {
    let id: Int
    let name: String
}
