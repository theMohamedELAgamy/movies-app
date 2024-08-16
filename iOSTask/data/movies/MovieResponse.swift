//
//  MovieResponse.swift
//  iOSTask
//
//  Created by Mohamed Nabil on 16/08/2024.
//

import Foundation

struct MovieResponse: Codable {
    
    var page: Int?
    var results: [Movie]?
    var totalPages: Int?
    var totalResults: Int?
    
    enum CodingKeys: String, CodingKey {
        case page
        case results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}
