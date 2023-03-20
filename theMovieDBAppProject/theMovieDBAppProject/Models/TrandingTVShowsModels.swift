//
//  TrandingTVShowsModels.swift
//  theMovieDBAppProject
//
//  Created by Serhii on 1/21/23.

import Foundation

// MARK: - TrandingTVShows
struct TrandingTVShows: Codable {
    let page: Int
    let results: [TVShows]
    let totalPages: Int
    let totalResults: Int
    
    enum CodingKeys: String, CodingKey {
        case page
        case results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

// MARK: - TVShows
struct TVShows: Codable {
    let adult: Bool?
    let backdropPath: String?
    let id: Int?
    let name: String?
    var originalLanguage: String?
    let originalName: String?
    let overview: String?
    let posterPath: String?
    let mediaType: String?
    let genreIDS: [Int]?
    let popularity: Double?
    let firstAirDate: String?
    let voteAverage: Double?
    let voteCount: Int?
    let originCountry: [String]?
    
    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case id
        case name
        case originalLanguage = "original_language"
        case originalName = "original_name"
        case overview
        case posterPath = "poster_path"
        case mediaType = "media_type"
        case genreIDS = "genre_ids"
        case popularity
        case firstAirDate = "first_air_date"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case originCountry = "origin_country"
    }
}


