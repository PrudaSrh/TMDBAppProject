//
//  SearchResultMediaModels.swift
//  theMovieDBAppProject
//
//  Created by Serhii on 2/25/23.
//

import Foundation

// MARK: - SearchResultMediaMulti
struct SearchResultMediaMulti: Codable {
    let page: Int
    let results: [SearchResultMedia]
    let totalPages: Int
    let totalResults: Int
    
    enum CodingKeys: String, CodingKey {
        case page
        case results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

// MARK: - SearchResultMedia
struct SearchResultMedia: Codable {
    let adult: Bool
    let backdropPath: String?
    let id: Int
    let title: String?
    let originalLanguage: String
    let originalTitle: String?
    let overview: String
    let posterPath: String
    let mediaType: String?
    let genreIDS: [Int]
    let popularity: Double
    let releaseDate: String?
    let video: Bool?
    let voteAverage: Double
    let voteCount: Int
    let name: String?
    let originalName: String?
    let firstAirDate: String?
    let originCountry: [String]?
    
    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case id
        case title
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview
        case posterPath = "poster_path"
        case mediaType = "media_type"
        case genreIDS = "genre_ids"
        case popularity
        case releaseDate = "release_date"
        case video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case name
        case originalName = "original_name"
        case firstAirDate = "first_air_date"
        case originCountry = "origin_country"
    }
}



