//
//  Constants.swift
//  theMovieDBAppProject
//
//  Created by Serhii on 1/09/23.
//

import UIKit

// MARK: - APIs path and constans
enum APIs: String {
    case apiKey = "c7d6331c4f99dbf246f413e9e34ff5a3"
    case baseURL = "https://api.themoviedb.org/3/"
    case getTrendingMovies = "https://api.themoviedb.org/3/trending/movie/week?api_key=c7d6331c4f99dbf246f413e9e34ff5a3"
    case getTrendingTVs = "https://api.themoviedb.org/3/trending/tv/week?api_key=c7d6331c4f99dbf246f413e9e34ff5a3"
    case getImage = "https://image.tmdb.org/t/p/original"
    case searchMovie = "https://api.themoviedb.org/3/search/movie"
    case searchTVShows = "https://api.themoviedb.org/3/search/tv"
    case getVideoMovie = "https://api.themoviedb.org/3/movie/{movie_id}/videos?api_key=c7d6331c4f99dbf246f413e9e34ff5a3&language=en-US"
    
    case getVideos = "https://api.themoviedb.org/3/movie/550?api_key=c7d6331c4f99dbf246f413e9e34ff5a3&append_to_response=videos"

    case getVideoTvShows = "https://api.themoviedb.org/3/tv/{movie_id}/videos?api_key=c7d6331c4f99dbf246f413e9e34ff5a3&language=en-US"

}
// MARK: - Video type
enum VideoType: String {
    case movie
    case tv
}
// MARK: - Media type
enum MediaType: String, CodingKey {
    case tv = "tv"
    case movie = "movie"
}

