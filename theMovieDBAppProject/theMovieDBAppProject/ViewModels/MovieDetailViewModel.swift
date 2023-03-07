//
//  MovieDetailViewModel.swift
//  theMovieDBAppProject
//
//  Created by Serhii on 2/14/23.
//

import UIKit
import Alamofire
import YoutubePlayer_in_WKWebView

class MovieDetailViewModel {
    var vcMovieDetailView: MovieDetailViewController?
    var typeSegment: TrendingMovieViewController?
    var videosPath: [String] = []
    var test: Bool = true
    
    var media: SearchResultMedia?
    var movie: Movie?
    var tv: TVShows?
    
    
    init(media: SearchResultMedia, test: Bool) {
        self.media = media
        self.test = test
    }
    
    init(movie: Movie) {
        self.movie = movie
    }
    
    init(tv: TVShows) {
        self.tv = tv
    }
    
    // MARK: - Videos reguest Movie
    func getTrailerMovie(completion: @escaping ([ResultVideo]) -> Void) {
        guard let movieId = movie?.id else {
            return
        }
        let urlString = "https://api.themoviedb.org/3/movie/\(movieId)/videos?api_key=c7d6331c4f99dbf246f413e9e34ff5a3&language=en-US"
        AF.request(urlString).responseDecodable(of: ResponseVideoTrailers.self) { response in
            let results = response.value?.results ?? []
            completion(results)
        }
    }
    
    // MARK: - Videos reguest TVShow
    func getTrailerTVShow(completion: @escaping ([ResultVideo]) -> Void) {
        guard let movieId = tv?.id else {
            return
        }
        let urlString = "https://api.themoviedb.org/3/tv/\(movieId)/videos?api_key=c7d6331c4f99dbf246f413e9e34ff5a3&language=en-US"
        AF.request(urlString).responseDecodable(of: ResponseVideoTrailers.self) { response in
            let results = response.value?.results ?? []
            completion(results)
        }
    }
    
    // MARK: - Videos reguest Media
    func getTrailerMedia(completion: @escaping ([ResultVideo]) -> Void) {
        switch test {
        case true:
            if let movieId = media?.id {
                let urlString = "https://api.themoviedb.org/3/movie/\(movieId)/videos?api_key=c7d6331c4f99dbf246f413e9e34ff5a3&language=en-US"
                AF.request(urlString).responseDecodable(of: ResponseVideoTrailers.self) { response in
                    let results = response.value?.results ?? []
                    completion(results)
                }
            }
        case false:
            if let movieId = media?.id {
                let urlString = "https://api.themoviedb.org/3/tv/\(movieId)/videos?api_key=c7d6331c4f99dbf246f413e9e34ff5a3&language=en-US"
                AF.request(urlString).responseDecodable(of: ResponseVideoTrailers.self) { response in
                    let results = response.value?.results ?? []
                    completion(results)
                }
                
            }
        }
    }
}


