//
//  SearchMediaViewModel.swift
//  theMovieDBAppProject
//
//  Created by Serhii on 3/2/23.
//

import Foundation
import Alamofire

class SearchMediaViewModel {
    static var stateSegment: MediaType = .movie
    
    var searchResultsMedia: [SearchResultMedia] = []
    
    //    func searchMedia(query: String, mediaType: MediaType, completion: @escaping ([SearchResultMedia]) -> Void) {
    //
    //        let baseURL = "https://api.themoviedb.org/3/search/"
    //        let mediaString: String
    //        switch mediaType {
    //        case .movie:
    //            mediaString = "movie"
    //        case .tv:
    //            mediaString = "tv"
    //        }
    //        let urlString = "\(baseURL)\(mediaString)?api_key=c7d6331c4f99dbf246f413e9e34ff5a3&language=en-US&query=\(query)"
    //        AF.request(urlString).responseDecodable(of: SearchResultMediaMulti.self) { response in
    //            guard let results = response.value?.results else {
    //                return
    //            }
    //            completion(results)
    //        }
    //    }
}

